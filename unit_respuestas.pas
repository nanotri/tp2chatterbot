unit unit_respuestas;

interface

uses
  Classes;

procedure ResponderPregunta(preg: string);
function PuntajeCapacitaciones(kws: TStringList): integer;
function PuntajeAlumnos(kws: TStringList): integer;
function PuntajeDocentes(kws: TStringList): integer;
function PuntajeEstadisticas(kws: TStringList): integer;


implementation

uses
  unit_texto,
  tipos,
  unit_keywords;

function ConsultaCapacitaciones(preg: string): boolean;
begin
  ConsultaCapacitaciones:=
    fraseKeyword(preg, 'capacitacion') or
    fraseKeyword(preg, 'capacitaciones') or
    fraseKeyword(preg, 'curso') or
    fraseKeyword(preg, 'taller') or
    fraseKeyword(preg, 'seminario');
end;

function EsConsultaCapacitaciones(preg: string): boolean;
begin
  EsConsultaCapacitaciones:=
    fraseKeyword(preg, 'capacitacion') or
    fraseKeyword(preg, 'capacitaciones') or
    fraseKeyword(preg, 'curso') or
    fraseKeyword(preg, 'taller') or
    fraseKeyword(preg, 'seminario') or
    fraseKeyword(preg, 'duracion') or
    fraseKeyword(preg, 'horas') or
    fraseKeyword(preg, 'vigente') or
    fraseKeyword(preg, 'activo') or
    fraseKeyword(preg, 'area');
end;

function ConsultaAlumnos(preg: string): boolean;
begin
  ConsultaAlumnos:=
    fraseKeyword(preg, 'alumno') or
    fraseKeyword(preg, 'alumnos');
end;

function ConsultaDocentes(preg: string): boolean;
begin
  ConsultaDocentes:=
    fraseKeyword(preg, 'docente') or
    fraseKeyword(preg, 'docentes');
end;

procedure MostrarCapacitacionesActivas;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
begin
  Assign(arch, 'capacitaciones.dat');
  Reset(arch);

  writeln('Capacitaciones activas:');

  while not EOF(arch) do
  begin
    Read(arch, cap);
    if cap.Estado then
      writeln('- ', cap.Nombre);
  end;

  Close(arch);
end;

function AreaTexto(preg: string): integer;
begin
  AreaTexto:= 0;
  if fraseKeyword(preg, 'isi') then AreaTexto:= 1
  else if fraseKeyword(preg, 'loi') then AreaTexto:= 2
  else if fraseKeyword(preg, 'civil') then AreaTexto:= 3
  else if fraseKeyword(preg, 'electro') then AreaTexto:= 4
  else if fraseKeyword(preg, 'general') then AreaTexto:= 5;
end;

procedure MostrarCapacitacionesPorArea(area: integer);
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
begin
  Assign(arch, 'capacitaciones.dat');
  Reset(arch);

  writeln('Capacitaciones del area seleccionada:');

  while not EOF(arch) do
  begin
    Read(arch, cap);
    if (cap.Area = area) and cap.Estado then
      writeln('- [', cap.Codigo, '] ', cap.Nombre);
  end;

  Close(arch);
end;

procedure MostrarDuracion;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
begin
  Assign(arch, 'capacitaciones.dat');
  Reset(arch);

  writeln('Duracion de las capacitaciones:');

  while not EOF(arch) do
  begin
    Read(arch, cap);
    writeln(cap.Nombre, ': ', cap.CantidadHoras, ' horas');
  end;

  Close(arch);
end;

procedure MostrarAprobados;
var
  arch: T_ARCHIVO_ALU;
  alu: T_DATO_ALUMNOS;
begin
  Assign(arch, 'alumnos.dat');
  Reset(arch);

  writeln('Alumnos aprobados:');

  while not EOF(arch) do
  begin
    Read(arch, alu);
    if alu.Estado and alu.Condicion then
      writeln('- ', alu.ApyNom);
  end;

  Close(arch);
end;

procedure MostrarDocentes;
var
  arch: T_ARCHIVO_ALU;
  alu: T_DATO_ALUMNOS;
begin
  Assign(arch, 'alumnos.dat');
  Reset(arch);

  writeln('Docentes UTN:');

  while not EOF(arch) do
  begin
    Read(arch, alu);
    if alu.Estado and alu.DocenteUTN then
      writeln('- ', alu.ApyNom, ' (Capacitacion ', alu.Codigo, ')');
  end;

  Close(arch);
end;

procedure EstadisticaDistribucionFechas;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
  cursos, talleres, seminarios: integer;
begin
  cursos:= 0;
  talleres:= 0;
  seminarios:= 0;

  Assign(arch, 'capacitaciones.dat');
  Reset(arch);

  while not EOF(arch) do
  begin
    Read(arch, cap);
    if cap.Estado then
      case cap.Tipo of
        1: cursos:= cursos + 1;
        2: talleres:= talleres + 1;
        3: seminarios:= seminarios + 1;
      end;
  end;

  Close(arch);

  writeln('Distribucion de capacitaciones:');
  writeln('- Cursos: ', cursos);
  writeln('- Talleres: ', talleres);
  writeln('- Seminarios: ', seminarios);
end;

procedure EstadisticaPorArea;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
  total: integer;
  area: array[1..5] of integer;
  i: integer;
begin
  total:= 0;
  for i:= 1 to 5 do
    area[i]:= 0;

  Assign(arch, 'capacitaciones.dat');
  Reset(arch);

  while not EOF(arch) do
  begin
    Read(arch, cap);
    if cap.Estado then
    begin
      total:= total + 1;
      area[cap.Area]:= area[cap.Area] + 1;
    end;
  end;

  Close(arch);

  writeln('Porcentaje de capacitaciones por area:');
  if total > 0 then
    for i:= 1 to 5 do
      writeln('Area ', i, ': ', (area[i] * 100) div total, '%');
end;

procedure EstadisticaEstadoCapacitaciones;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
  activas, inactivas: integer;
begin
  activas:= 0;
  inactivas:= 0;

  Assign(arch, 'capacitaciones.dat');
  Reset(arch);

  while not EOF(arch) do
  begin
    Read(arch, cap);
    if cap.Estado then
      activas:= activas + 1
    else
      inactivas:= inactivas + 1;
  end;

  Close(arch);

  writeln('Estado de las capacitaciones:');
  writeln('- Activas: ', activas);
  writeln('- Inactivas: ', inactivas);
end;

function PuntajeConsulta(kws: TStringList): integer;
var
  i: integer;
begin
  Result:= 0;

  for i:= 0 to kws.Count - 1 do
  begin
    if esKeyword(kws[i]) then
      Result:= Result + 3;

    if kws[i] = 'duracion' then
      Result:= Result + 2;

    if kws[i] = 'area' then
      Result:= Result + 2;

    if (kws[i] = 'activo') or (kws[i] = 'vigente') then
      Result:= Result + 2;
  end;
end;

function PuntajeCapacitaciones(kws: TStringList): integer;
var
  i: integer;
begin
  Result:= 0;
  for i:= 0 to kws.Count - 1 do
  begin
    if esKeyword(kws[i]) then
      Result:= Result + 2;

    if (kws[i] = 'capacitacion') or (kws[i] = 'capacitaciones')
       or (kws[i] = 'curso') or (kws[i] = 'taller')
       or (kws[i] = 'seminario') then
      Result:= Result + 3;

    if (kws[i] = 'activo') or (kws[i] = 'vigente') then
      Result:= Result + 2;
  end;
end;

function PuntajeAlumnos(kws: TStringList): integer;
var
  i: integer;
begin
  Result:= 0;
  for i:= 0 to kws.Count - 1 do
  begin
    if (kws[i] = 'alumno') or (kws[i] = 'alumnos') then
      Result:= Result + 3;

    if (kws[i] = 'aprobado') or (kws[i] = 'aprobados') then
      Result:= Result + 2;
  end;
end;

function PuntajeDocentes(kws: TStringList): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to kws.Count - 1 do
    if (kws[i] = 'docente') or (kws[i] = 'docentes') then
      Result := Result + 3;
end;

function PuntajeEstadisticas(kws: TStringList): integer;
var
  i: integer;
begin
  Result:= 0;
  for i:= 0 to kws.Count - 1 do
    if (kws[i] = 'estadistica') or (kws[i] = 'estadisticas')
       or (kws[i] = 'estado') or (kws[i] = 'distribucion') then
      Result:= Result + 3;
end;

procedure ResponderPregunta(preg: string);
var
  limpia: string;
  kws: TStringList;
  pCap, pAlu, pDoc, pEst: integer;
begin
  limpia := LimpiarFrase(preg);
  kws := extraerKeywords(limpia);

  pCap := PuntajeCapacitaciones(kws);
  pAlu := PuntajeAlumnos(kws);
  pDoc := PuntajeDocentes(kws);
  pEst := PuntajeEstadisticas(kws);

  if (pCap >= pAlu) and (pCap >= pDoc) and (pCap >= pEst) and (pCap > 0) then
  begin
    if fraseKeyword(limpia, 'activo') or fraseKeyword(limpia, 'vigente') then
      MostrarCapacitacionesActivas
    else if fraseKeyword(limpia, 'area') then
      MostrarCapacitacionesPorArea(AreaTexto(limpia))
    else if fraseKeyword(limpia, 'duracion') then
      MostrarDuracion
    else
      MostrarCapacitacionesActivas;
  end
  else if (pAlu > pCap) and (pAlu >= pDoc) and (pAlu >= pEst) then
  begin
    if fraseKeyword(limpia, 'aprobado') then
      MostrarAprobados
    else
      writeln('Debe indicar si desea alumnos aprobados.');
  end
  else if (pDoc > pCap) and (pDoc > pAlu) and (pDoc >= pEst) then
    MostrarDocentes
  else if (pEst > 0) then
    EstadisticaEstadoCapacitaciones
  else
    writeln('No entiendo la consulta. Intente nuevamente.');

  kws.Free;
end;
end.
