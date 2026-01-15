program stop;
var
  te: Text;
begin
  Assign(te, 'stopwords.txt');
  Rewrite(te);

  Writeln(te, 'que');
  Writeln(te, 'de');
  Writeln(te, 'hay');
  Writeln(te, 'los');
  Writeln(te, 'las');
  Writeln(te, 'un');
  Writeln(te, 'una');
  Writeln(te, 'el');
  Writeln(te, 'la');
  Writeln(te, 'por');
  Writeln(te, 'para');

  Close(te);
end.


