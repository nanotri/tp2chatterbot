unit unit_respuestas;

interface

procedure ResponderPregunta(preg: string);

implementation

uses
  SysUtils,
  unit_texto,
  tipos,
  unit_keywords,
  unit_archivos;

function AreaTexto(preg: string): integer;
begin
  AreaTexto := 0;
  if FraseKeyword(preg, 'isi') then
    AreaTexto := 1
  else if FraseKeyword(preg, 'loi') then
    AreaTexto := 2
  else if FraseKeyword(preg, 'civil') then
    AreaTexto := 3
  else if FraseKeyword(preg, 'electro') then
    AreaTexto := 4
  else if FraseKeyword(preg, 'general') then
    AreaTexto := 5;
end;

procedure MostrarCapacitacionesActivas;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
begin
  if AbrirCapacitaciones(arch) then
  begin
    writeln('Capacitaciones activas:');
    while not EOF(arch) do
    begin
      Read(arch, cap);
      if cap.Estado then
        writeln('- ', cap.Nombre);
    end;
    Close(arch);
  end
  else
    writeln('No se pudo abrir capacitaciones.dat');
end;

procedure MostrarCapacitacionesPorArea(area: integer);
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
begin

  if AbrirCapacitaciones(arch) then
  begin
    writeln('Capacitaciones del area seleccionada:');
    while not EOF(arch) do
    begin
      Read(arch, cap);
      if (cap.Area = area) and cap.Estado then
        writeln('- [', cap.Codigo, '] ', cap.Nombre);
    end;
    Close(arch);
  end
  else
    writeln('No se pudo abrir capacitaciones.dat');
end;

procedure MostrarDuracion;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
  horas: string;
begin
  if AbrirCapacitaciones(arch) then
  begin
    writeln('Duracion de las capacitaciones:');
    while not EOF(arch) do
    begin
      Read(arch, cap);

      if Abs(Frac(cap.CantidadHoras)) < 0.001 then
        Str(cap.CantidadHoras: 0: 0, horas)
      else
        Str(cap.CantidadHoras: 0: 2, horas);

      writeln(cap.Nombre, ': ', horas, ' horas');
    end;
    Close(arch);
  end
  else
    writeln('No se pudo abrir capacitaciones.dat');
end;

procedure MostrarAprobados;
var
  arch: T_ARCHIVO_ALU;
  alu: T_DATO_ALUMNOS;
begin
  if AbrirAlumnos(arch) then
  begin
    writeln('Alumnos aprobados:');
    while not EOF(arch) do
    begin
      Read(arch, alu);
      if alu.Estado and alu.Condicion then
        writeln('- ', alu.ApyNom);
    end;
    Close(arch);
  end
  else
    writeln('No se pudo abrir alumnos.dat');
end;

procedure MostrarDocentes;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
  i, contDocentes, contPaginacion: integer;
  opcion: string;
begin
  if AbrirCapacitaciones(arch) then
  begin
    writeln('--- LISTADO DE DOCENTES (Presione Enter para avanzar) ---');

    contPaginacion := 0;

    while not EOF(arch) do
    begin
      Read(arch, cap);

      if cap.Estado then
      begin
        writeln('--------------------------------------------------');
        writeln('Capacitacion: ', cap.Nombre);

        contDocentes := 0;
        for i := 1 to 4 do
        begin
          if Trim(cap.Docentes[i]) <> '' then
          begin
            writeln('   -> ', cap.Docentes[i]);
            contDocentes := contDocentes + 1;
          end;
        end;

        if contDocentes = 0 then
          writeln('   (Sin docentes asignados)');

        contPaginacion := contPaginacion + 1;

        if contPaginacion = 3 then
        begin
          writeln;
          Write('Presione ENTER para ver mas: ');
          readln(opcion);

          contPaginacion := 0;
          writeln;
        end;
      end;
    end;
    Close(arch);
    writeln('--------------------------------------------------');
  end
  else
    writeln('No se pudo abrir capacitaciones.dat');
end;

procedure EstadisticaDistribucionTipos;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
  cursos, talleres, seminarios: integer;
begin
  cursos := 0;
  talleres := 0;
  seminarios := 0;

  if AbrirCapacitaciones(arch) then
  begin
    while not EOF(arch) do
    begin
      Read(arch, cap);
      if cap.Estado then
        case cap.Tipo of
          1: cursos := cursos + 1;
          2: talleres := talleres + 1;
          3: seminarios := seminarios + 1;
        end;
    end;

    Close(arch);

    writeln('Distribucion de capacitaciones:');
    writeln('- Cursos: ', cursos);
    writeln('- Talleres: ', talleres);
    writeln('- Seminarios: ', seminarios);
  end
  else
    writeln('No se pudo abrir capacitaciones.dat');
end;

procedure EstadisticaPorArea;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
  total: integer;
  area: array[1..5] of integer;
  i: integer;
begin
  total := 0;
  for i := 1 to 5 do
    area[i] := 0;

  if AbrirCapacitaciones(arch) then
  begin
    while not EOF(arch) do
    begin
      Read(arch, cap);
      if cap.Estado then
      begin
        total := total + 1;
        if (cap.Area >= 1) and (cap.Area <= 5) then
          area[cap.Area] := area[cap.Area] + 1;
      end;
    end;

    Close(arch);

    writeln('Porcentaje de capacitaciones por area:');
    if total > 0 then
      for i := 1 to 5 do
        writeln('Area ', i, ': ', (area[i] * 100) div total, '%')
    else
      writeln('No hay capacitaciones activas.');
  end
  else
    writeln('No se pudo abrir capacitaciones.dat');
end;

procedure EstadisticaEstadoCapacitaciones;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
  activas, inactivas: integer;
begin
  activas := 0;
  inactivas := 0;

  if AbrirCapacitaciones(arch) then
  begin
    while not EOF(arch) do
    begin
      Read(arch, cap);
      if cap.Estado then
        activas := activas + 1
      else
        inactivas := inactivas + 1;
    end;

    Close(arch);

    writeln('Estado de las capacitaciones:');
    writeln('- Activas: ', activas);
    writeln('- Inactivas: ', inactivas);
  end
  else
    writeln('No se pudo abrir capacitaciones.dat');
end;

function PuntajeCapacitaciones(const kws: TKeywords; n: integer): integer;
var
  i: integer;
begin
  PuntajeCapacitaciones := 0;
  for i := 1 to n do
  begin
    if (kws[i] = 'ver') or (kws[i] = 'mostrar') or (kws[i] = 'listar') or
      (kws[i] = 'quiero') then
      PuntajeCapacitaciones := PuntajeCapacitaciones + 1;

    if EsKeyword(kws[i]) then
      PuntajeCapacitaciones := PuntajeCapacitaciones + 2;

    if (kws[i] = 'capacitacion') or (kws[i] = 'capacitaciones') or
      (kws[i] = 'curso') or (kws[i] = 'cursos') or (kws[i] = 'taller') or
      (kws[i] = 'seminario') then
      PuntajeCapacitaciones := PuntajeCapacitaciones + 3;

    if (kws[i] = 'activo') or (kws[i] = 'vigente') or (kws[i] = 'vigentes') then
      PuntajeCapacitaciones := PuntajeCapacitaciones + 2;
  end;
end;

function PuntajeAlumnos(const kws: TKeywords; n: integer): integer;
var
  i: integer;
begin
  PuntajeAlumnos := 0;
  for i := 1 to n do
  begin
    if (kws[i] = 'alumno') or (kws[i] = 'alumnos') then
      PuntajeAlumnos := PuntajeAlumnos + 3;

    if (kws[i] = 'aprobado') or (kws[i] = 'aprobados') then
      PuntajeAlumnos := PuntajeAlumnos + 2;
  end;
end;

function PuntajeDocentes(const kws: TKeywords; n: integer): integer;
var
  i: integer;
begin
  PuntajeDocentes := 0;
  for i := 1 to n do
    if (kws[i] = 'docente') or (kws[i] = 'docentes') then
      PuntajeDocentes := PuntajeDocentes + 3;
end;

function PuntajeEstadisticas(const kws: TKeywords; n: integer): integer;
var
  i: integer;
begin
  PuntajeEstadisticas := 0;
  for i := 1 to n do
    if (kws[i] = 'estadistica') or (kws[i] = 'estadisticas') or
      (kws[i] = 'estado') or (kws[i] = 'distribucion') then
      PuntajeEstadisticas := PuntajeEstadisticas + 3;
end;

procedure ResponderPregunta(preg: string);
var
  limpia: string;
  kws: TKeywords;
  n: integer;
  pCap, pAlu, pDoc, pEst: integer;
  area: integer;
  tieneArea: boolean;
begin
  limpia := LimpiarFrase(preg);

  ExtraerKeywords(limpia, kws, n);

  pCap := PuntajeCapacitaciones(kws, n);
  pAlu := PuntajeAlumnos(kws, n);
  pDoc := PuntajeDocentes(kws, n);
  pEst := PuntajeEstadisticas(kws, n);

  { Determinar si hay área válida }
  area := AreaTexto(limpia);
  tieneArea := (area >= 1) and (area <= 5);

  if (pCap >= pAlu) and (pCap >= pDoc) and (pCap >= pEst) and (pCap > 0) then
  begin
    if FraseKeyword(limpia, 'activo') or FraseKeyword(limpia, 'vigente') then
      MostrarCapacitacionesActivas
    else if FraseKeyword(limpia, 'area') or tieneArea then
    begin
      if tieneArea then
        MostrarCapacitacionesPorArea(area)
      else
        writeln('Indique un area valida (ISI, LOI, CIVIL, ELECTRO, GENERAL).');
    end
    else if FraseKeyword(limpia, 'duracion') or FraseKeyword(limpia, 'horas') then
      MostrarDuracion
    else
      MostrarCapacitacionesActivas;
  end
  else if (pAlu > pCap) and (pAlu >= pDoc) and (pAlu >= pEst) then
  begin
    if FraseKeyword(limpia, 'aprobado') or FraseKeyword(limpia, 'aprobados') then
      MostrarAprobados
    else
      writeln('Debe indicar si desea alumnos aprobados.');
  end
  else if (pDoc > pCap) and (pDoc > pAlu) and (pDoc >= pEst) then
    MostrarDocentes
  else if (pEst > 0) then
  begin
    if FraseKeyword(limpia, 'distribucion') then
      EstadisticaDistribucionTipos
    else if FraseKeyword(limpia, 'area') then
      EstadisticaPorArea
    else
      EstadisticaEstadoCapacitaciones;
  end
  else
    writeln('No entiendo la consulta. Intente nuevamente.');
end;

end.
