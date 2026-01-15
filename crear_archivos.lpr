program crear_archivos;

{$H-}

uses
  tipos;

var
  archCap: T_ARCHIVO_CAP;
  archAlu: T_ARCHIVO_ALU;
  c: T_DATO_CAPACITACIONES;
  a: T_DATO_ALUMNOS;

begin
  // CAPACITACIONES------
  Assign(archCap, 'capacitaciones.dat');
  Rewrite(archCap);

  c.Codigo := 111111;
  c.Nombre := 'Inteligencia Artificial';
  c.Tipo := 1;
  c.CantidadHoras := 40;
  c.CantidadDocentes := 1;
  c.Docentes[1] := 'Perez Jose';
  c.CantidadInscriptos := 30;
  c.Area := 1;
  c.Estado := True;
  Write(archCap, c);

  c.Codigo := 222222;
  c.Nombre := 'Marketing digital';
  c.Tipo := 2;
  c.CantidadHoras := 12;
  c.CantidadDocentes := 1;
  c.Docentes[1] := 'Martinez Lucia';
  c.CantidadInscriptos := 25;
  c.Area := 5;
  c.Estado := True;
  Write(archCap, c);

  Close(archCap);


  // ALUMNOS------------
  Assign(archAlu, 'alumnos.dat');
  Rewrite(archAlu);

  a.Codigo := 111111;
  a.DNI := '34567853';
  a.ApyNom := 'Martinez Lucia';
  a.DocenteUTN := True;
  a.Condicion := True;
  a.Estado := True;
  Write(archAlu, a);

  a.Codigo := 333333;
  a.DNI := '45673456';
  a.ApyNom := 'Perez Jose';
  a.DocenteUTN := True;
  a.Condicion := False;
  a.Estado := True;
  Write(archAlu, a);

  a.Codigo := 222222;
  a.DNI := '54536572';
  a.ApyNom := 'Gomez Lara';
  a.DocenteUTN := False;
  a.Condicion := True;
  a.Estado := False;
  Write(archAlu, a);

  Close(archAlu);

  writeln('Archivos creados correctamente.');
  readln;
end.

