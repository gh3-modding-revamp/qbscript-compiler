using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Antlr4.Runtime;

namespace GH3MR.Scripting
{
    class Program
    {
        static void Main(string[] args)
        {
            // TODO: find a nicer way to handle parsing?  Or is this it?
            string testHeader = "script MyScript()";
            using (var sr = new StringReader(testHeader))
            {
                var stream = new UnbufferedCharStream(sr);
                var lexer = new QbScriptLexer(stream);
                var tokens = new CommonTokenStream(lexer);
                var parser = new QbScriptParser(tokens);

                var visitor = new QbScriptBaseVisitor<int>();
                visitor.Visit(parser.scriptHeader());
            }
        }
    }
}
