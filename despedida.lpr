program despedida;
var
t:text ;

begin
Assign(t, 'despedidas.txt');
Rewrite(t);
Writeln(t, 'chau');
Writeln(t, 'adios');
Writeln(t, 'nos vemos');
Writeln(t, 'gracias');
Writeln(t, 'hasta luego');
Writeln(t, 'chao');
Writeln(t, 'bye');
Writeln(t, 'hasta la proxima');

Close(t);
end.

