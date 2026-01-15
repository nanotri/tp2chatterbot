program saludo;
var
  t: text;

begin
Assign(t, 'saludos.txt');
Rewrite(t);
Writeln(t, 'hola');
Writeln(t, 'buen dia');
Writeln(t, 'buenas');
Writeln(t, 'que tal');
Writeln(t, 'que onda');
Writeln(t, 'holi');
Writeln(t, 'hi');
Writeln(t, 'buenos dias');
Writeln(t, 'buenas noches');
Writeln(t, 'buenas tardes');
Writeln(t, 'como estas');

Close(t);
end.

