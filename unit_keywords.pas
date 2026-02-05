unit unit_keywords;

interface

uses
  unit_archivos;

const
  MAX_KWS = 60;

type
  TKeywords = array[1..MAX_KWS] of string;

function EsKeyword(palabra: string): boolean;
function EsStopword(palabra: string): boolean;
function FraseKeyword(frase, clave: string): boolean;
function ContieneKeyword(frase: string): boolean;

procedure ExtraerKeywords(frase: string; var kws: TKeywords; var n: integer);

implementation

uses
  SysUtils;

function FraseKeyword(frase, clave: string): boolean;
begin
  FraseKeyword := Pos(clave, frase) > 0;
end;

function EsKeyword(palabra: string): boolean;
begin
  palabra := Trim(LowerCase(palabra));
  
  if palabra = '' then
    EsKeyword := False
  else
    EsKeyword := BuscarEnArchivoConLevenshtein('keywords', palabra, 1);
end;

function EsStopword(palabra: string): boolean;
begin
  palabra := Trim(LowerCase(palabra));
  
  if palabra = '' then
    EsStopword := False
  else
    EsStopword := BuscarEnArchivoConLevenshtein('stopwords', palabra, 1);
end;

function ContieneKeyword(frase: string): boolean;
var
  palabra: string;
  i: integer;
  encontrado: boolean;
begin
  frase := Trim(LowerCase(frase));
  palabra := '';
  encontrado := False;

  for i := 1 to Length(frase) do
  begin
    if frase[i] <> ' ' then
      palabra := palabra + frase[i]
    else
    begin
      if (palabra <> '') and (not encontrado) then
        if EsKeyword(palabra) then
          encontrado := True;

      palabra := '';
    end;
  end;

  if (palabra <> '') and (not encontrado) then
    if EsKeyword(palabra) then
      encontrado := True;

  ContieneKeyword := encontrado;
end;

procedure ExtraerKeywords(frase: string; var kws: TKeywords; var n: integer);
var
  palabra: string;
  i: integer;
begin
  n := 0;
  palabra := '';
  frase := Trim(LowerCase(frase));

  for i := 1 to Length(frase) do
  begin
    if frase[i] <> ' ' then
      palabra := palabra + frase[i]
    else
    begin
      if palabra <> '' then
      begin
        if n < MAX_KWS then
        begin
          Inc(n);
          kws[n] := palabra;
        end;
        palabra := '';
      end;
    end;
  end;

  if palabra <> '' then
    if n < MAX_KWS then
    begin
      Inc(n);
      kws[n] := palabra;
    end;
end;

end.