program key;
var
  te: Text;
begin
  Assign(te, 'keywords.txt');
  Rewrite(te);

  Writeln(te, 'curso;TIPO;1');
  Writeln(te, 'cursos;TIPO;1');
  Writeln(te, 'taller;TIPO;2');
  Writeln(te, 'talleres;TIPO;2');
  Writeln(te, 'seminario;TIPO;3');
  Writeln(te, 'seminarios;TIPO;3');
  Writeln(te, 'activo;ESTADO;true');
  Writeln(te, 'activos;ESTADO;true');
  Writeln(te, 'vigente;ESTADO;true');
  Writeln(te, 'disponible;ESTADO:true');
  Writeln(te, 'terminado;ESTADO;false');
  Writeln(te, 'no activo;ESTADO:false');
  Writeln(te, 'finalizado;ESTADO;false');
  Writeln(te, 'inactivo;ESTADO;false');
  Writeln(te, 'inicio;CAMPO;FECHA_INICIO');
  Writeln(te, 'fin;CAMPO;FECHA_FIN');
  Writeln(te, 'inscripto;CAMPO;INSCRIPTOS');
  Writeln(te, 'inscriptos;CAMPO;INSCRIPTOS');
  Writeln(te, 'alumno;ENTIDAD;ALUMNO');
  Writeln(te, 'alumnos;ENTIDAD;ALUMNO');
  Writeln(te, 'alumna;ENTIDAD;ALUMNO');
  Writeln(te, 'aprobado;CONDICION;true');
  Writeln(te, 'asistencia;CONDICION;false');
  Writeln(te, 'isi;Area;1');
  Writeln(te, 'loi;Area;2');
  Writeln(te, 'civil;Area;3');
  Writeln(te, 'electro;Area;4');
  Writeln(te, 'general;Area;5');

  Close(te);
end;

