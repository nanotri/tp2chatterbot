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
  //CAPACITACIONES-----
  Assign(archCap, 'capacitaciones.dat');
  Rewrite(archCap);

  c.Codigo := 111111;
  c.Nombre := 'Introduccion a la Programacion';
  c.Tipo := 1; // Curso
  c.CantidadHoras := 40;
  c.CantidadDocentes := 1;
  c.Docentes[1] := 'Perez Juan';
  c.CantidadInscriptos := 30;
  c.Area := 1; // ISI
  c.Estado := True;
  Write(archCap, c);

  c.Codigo := 222222;
  c.Nombre := 'Git y Control de Versiones';
  c.Tipo := 2; // Taller
  c.CantidadHoras := 12;
  c.CantidadDocentes := 1;
  c.Docentes[1] := 'Martinez Lucia';
  c.CantidadInscriptos := 25;
  c.Area := 5; // General
  c.Estado := True;
  Write(archCap, c);

  c.Codigo := 333333;
  c.Nombre := 'Seminario de Inteligencia Artificial';
  c.Tipo := 3; // Seminario
  c.CantidadHoras := 8;
  c.CantidadDocentes := 2;
  c.Docentes[1] := 'Gomez Ana';
  c.Docentes[2] := 'Lopez Carlos';
  c.CantidadInscriptos := 50;
  c.Area := 1; // ISI
  c.Estado := False;
  Write(archCap, c);

  Close(archCap);

  //ALUMNOS-----
  Assign(archAlu, 'alumnos.dat');
  Rewrite(archAlu);

  a.Codigo := 111111;
  a.DNI := '35673456';
  a.ApyNom := 'Martinez Lucia';
  a.DocenteUTN := True;
  a.Condicion := True;
  a.Estado := True;
  Write(archAlu, a);

  a.Codigo := 333333;
  a.DNI := '45673456';
  a.ApyNom := 'Perez Juan';
  a.DocenteUTN := False;
  a.Condicion := False;
  a.Estado := True;
  Write(archAlu, a);

  a.Codigo := 222222;
  a.DNI := '54536572';
  a.ApyNom := 'Gomez Ana';
  a.DocenteUTN := False;
  a.Condicion := True;
  a.Estado := False;
  Write(archAlu, a);

  Close(archAlu);

  writeln('Archivos creados correctamente.');
  readln;
end.

