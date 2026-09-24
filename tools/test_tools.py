#!/usr/bin/env python3
from __future__ import annotations
import json, subprocess, sys, tempfile, unittest
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
MAT=ROOT/"tools"/"cw-materialize.py"
META=ROOT/"tools"/"cw-meta-to-json.py"

class ToolTests(unittest.TestCase):
    def test_materialize_nested_utf8_and_comment(self):
        src=r"""Texto UTF-8: revisão, Xexéo.
\cwchange[id=one,author=alice]{velho {aninhado}}{novo {aninhado}}
% \cwchange[id=ignored]{A}{B}
\cwchange[id=two,status=rejected]{fica antigo}{não entra}
"""
        with tempfile.TemporaryDirectory() as d:
            d=Path(d); inp=d/"in.tex"; out=d/"out.tex"
            inp.write_text(src,encoding="utf-8")
            subprocess.run([sys.executable,str(MAT),str(inp),"-o",str(out),"--accept","one"],check=True)
            got=out.read_text(encoding="utf-8")
            self.assertIn("novo {aninhado}",got)
            self.assertIn("fica antigo",got)
            self.assertIn("% \\cwchange[id=ignored]{A}{B}",got)
            self.assertIn("Xexéo",got)

    def test_materializer_refuses_overwrite(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/"in.tex"; p.write_text(r"\cwchange[id=x]{a}{b}",encoding="utf-8")
            result=subprocess.run([sys.executable,str(MAT),str(p),"-o",str(p),"--accept","x"],capture_output=True,text=True)
            self.assertNotEqual(result.returncode,0)

    def test_metadata_json_utf8(self):
        with tempfile.TemporaryDirectory() as d:
            d=Path(d); tsv=d/"meta.tsv"; out=d/"meta.json"
            tsv.write_text("# coop-writing-meta-v1\nid\ttype\tauthor\tstatus\tseverity\tfile\tpage\tparent\tbody\told\tnew\n"
                           "x\tcomment\tgeraldo\topen\twarning\tcapítulo.tex\t2\t\trevisão\t\t\n",encoding="utf-8")
            subprocess.run([sys.executable,str(META),str(tsv),"-o",str(out)],check=True)
            data=json.loads(out.read_text(encoding="utf-8"))
            self.assertEqual(data[0]["body"],"revisão")
            self.assertEqual(data[0]["file"],"capítulo.tex")

if __name__=="__main__":
    unittest.main()
