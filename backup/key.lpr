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


  Writeln(te, 'isi;AREA;1');
  Writeln(te, 'loi;AREA;2');
  Writeln(te, 'civil;AREA;3');
  Writeln(te, 'electro;AREA;4');
  Writeln(te, 'general;AREA;5');

  Close(te);
end;

