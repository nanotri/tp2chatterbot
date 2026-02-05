unit unit_archivos;

{$mode ObjFPC}{$H+}

interface

uses
  tipos;

function BuscarEnArchivoTexto(nomArch, texto: string): boolean;
function BuscarEnArchivoConLevenshtein(nomArch, palabra: string; tolerancia: integer): boolean;
function AbrirOCrearArchivoTexto(nomArch: string; var arch: Text): boolean;

function AbrirCapacitaciones(var arch: T_ARCHIVO_CAP): boolean;
function BuscarCapacitacionPorCodigo(codigo: integer; var cap: T_DATO_CAPACITACIONES): boolean;
function ContarCapacitacionesActivas: integer;

function AbrirAlumnos(var arch: T_ARCHIVO_ALU): boolean;
function BuscarAlumnoPorDNI(dni: string; var alu: T_DATO_ALUMNOS): boolean;
function ContarAlumnosAprobados: integer;

implementation

uses
  SysUtils,
  unit_levenshtein;

function BuscarEnArchivoTexto(nomArch, texto: string): boolean;
var
  arch: Text;
  linea: string;
begin
  BuscarEnArchivoTexto := False;
  
  Assign(arch, nomArch);
  
  {$I-}
  Reset(arch);
  {$I+}
  
  if IOResult = 0 then
  begin
    while not EOF(arch) do
    begin
      ReadLn(arch, linea);
      if texto = linea then
        BuscarEnArchivoTexto := True;
    end;
    Close(arch);
  end;
end;

function AbrirOCrearArchivoTexto(nomArch: string; var arch: Text): boolean;
var
  io: integer;
begin
  AbrirOCrearArchivoTexto := False;
  
  Assign(arch, nomArch);
  
  {$I-}
  Reset(arch);
  io := IOResult;
  {$I+}
  
  if io = 0 then
    AbrirOCrearArchivoTexto := True
  else
  begin
    {$I-}
    Rewrite(arch);
    io := IOResult;
    {$I+}
    
    if io = 0 then
    begin
      Close(arch);
      
      {$I-}
      Reset(arch);
      io := IOResult;
      {$I+}
      
      if io = 0 then
        AbrirOCrearArchivoTexto := True;
    end;
  end;
end;

function BuscarEnArchivoConLevenshtein(nomArch, palabra: string; tolerancia: integer): boolean;
var
  arch: Text;
  linea: string;
  encontrado: boolean;
begin
  BuscarEnArchivoConLevenshtein := False;
  encontrado := False;
  palabra := Trim(LowerCase(palabra));
  
  if AbrirOCrearArchivoTexto(nomArch, arch) then
  begin
    while (not EOF(arch)) and (not encontrado) do
    begin
      ReadLn(arch, linea);
      linea := Trim(LowerCase(linea));
      
      if linea <> '' then
        if DistanciaLevenshtein(palabra, linea) <= tolerancia then
        begin
          encontrado := True;
          BuscarEnArchivoConLevenshtein := True;
        end;
    end;
    
    Close(arch);
  end;
end;

function AbrirCapacitaciones(var arch: T_ARCHIVO_CAP): boolean;
var
  io: integer;
begin
  AbrirCapacitaciones := False;
  Assign(arch, 'capacitaciones.dat');
  
  {$I-}
  Reset(arch);
  io := IOResult;
  {$I+}
  
  if io = 0 then
    AbrirCapacitaciones := True;
end;

function BuscarCapacitacionPorCodigo(codigo: integer; var cap: T_DATO_CAPACITACIONES): boolean;
var
  arch: T_ARCHIVO_CAP;
  encontrado: boolean;
begin
  BuscarCapacitacionPorCodigo := False;
  encontrado := False;
  
  if AbrirCapacitaciones(arch) then
  begin
    while (not EOF(arch)) and (not encontrado) do
    begin
      Read(arch, cap);
      if cap.Codigo = codigo then
      begin
        encontrado := True;
        BuscarCapacitacionPorCodigo := True;
      end;
    end;
    Close(arch);
  end;
end;

function ContarCapacitacionesActivas: integer;
var
  arch: T_ARCHIVO_CAP;
  cap: T_DATO_CAPACITACIONES;
  contador: integer;
begin
  contador := 0;
  
  if AbrirCapacitaciones(arch) then
  begin
    while not EOF(arch) do
    begin
      Read(arch, cap);
      if cap.Estado then
        contador := contador + 1;
    end;
    Close(arch);
  end;
  
  ContarCapacitacionesActivas := contador;
end;

function AbrirAlumnos(var arch: T_ARCHIVO_ALU): boolean;
var
  io: integer;
begin
  AbrirAlumnos := False;
  Assign(arch, 'alumnos.dat');
  
  {$I-}
  Reset(arch);
  io := IOResult;
  {$I+}
  
  if io = 0 then
    AbrirAlumnos := True;
end;

function BuscarAlumnoPorDNI(dni: string; var alu: T_DATO_ALUMNOS): boolean;
var
  arch: T_ARCHIVO_ALU;
  encontrado: boolean;
begin
  BuscarAlumnoPorDNI := False;
  encontrado := False;
  
  if AbrirAlumnos(arch) then
  begin
    while (not EOF(arch)) and (not encontrado) do
    begin
      Read(arch, alu);
      if alu.DNI = dni then
      begin
        encontrado := True;
        BuscarAlumnoPorDNI := True;
      end;
    end;
    Close(arch);
  end;
end;

function ContarAlumnosAprobados: integer;
var
  arch: T_ARCHIVO_ALU;
  alu: T_DATO_ALUMNOS;
  contador: integer;
begin
  contador := 0;
  
  if AbrirAlumnos(arch) then
  begin
    while not EOF(arch) do
    begin
      Read(arch, alu);
      if alu.Estado and alu.Condicion then
        contador := contador + 1;
    end;
    Close(arch);
  end;
  
  ContarAlumnosAprobados := contador;
end;

end.