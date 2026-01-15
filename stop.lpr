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
  Writeln(te, 'cual');
  Writeln(te, 'cuales');
  Writeln(te, 'es');
  Writeln(te, 'esta');
  Writeln(te, 'estan');
  Writeln(te, 'saber');
  Writeln(te, 'te');
  Writeln(te, 'puedo');
  Writeln(te, 'puedes');
  Writeln(te, 'preguntar');
  Writeln(te, 'le');
  Writeln(te, 'cuantos');
  Writeln(te, 'se');
  Writeln(te, 'si');
  Writeln(te, 'sobre');
  Writeln(te, 'algo');
   Writeln(te, 'me');

  Close(te);
end.


