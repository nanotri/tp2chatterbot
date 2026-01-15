program probar;
{$H-}
uses tipos;
var
  arch:T_ARCHIVO_CAP;
  c:T_DATO_CAPACITACIONES;
begin
  Assign(arch, 'capacitaciones.dat');
  Reset(arch);
  writeln('las capacitaciones:');
  while not EOF(arch) do
   begin
    Read(arch, c);
    writeln('Nombre: ', c.Nombre, ' | Area: ', c.Area, ' | Estado: ', c.Estado);
   end;
  Close(arch);
  readln;
end.


