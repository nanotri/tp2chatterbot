unit unit_keywords;
interface

function esKeyword(palabra: string): boolean;
function esStopword(palabra: string): boolean;
function fraseKeyword(frase, clave: string): boolean;
function contieneKeyword(frase: string): boolean;
function ExtraerKeywords(frase: string): TStringList;

implementation

uses
  unit_levenshtein,
  Classes;

function buscar(nomArch, palabra: string): boolean;
var
  arch: Text;
  linea: string;
begin
  buscar:= false;

  Assign(arch, nomArch);

  {$I-}
  Reset(arch);
  {$I+}

  if IOResult <> 0 then
  begin
    Rewrite(arch);
    Close(arch);
    Reset(arch);
  end;

  while not EOF(arch) do
  begin
    ReadLn(arch, linea);
    if DistanciaLevenshtein(palabra, linea) <= 1 then
      buscar:= true;
  end;

  Close(arch);
end;

function fraseKeyword(frase, clave: string): boolean;
begin
  fraseKeyword := Pos(clave, frase) > 0;
end;

function esKeyword(palabra: string): boolean;
begin
  esKeyword:= buscar('keywords', palabra);
end;

function esStopWord(palabra: string): boolean;
begin
  esStopWord:= buscar('stopwords', palabra);
end;

function contieneKeyword(frase: string): boolean;
var
  palabra: string;
  i: integer;
begin
  contieneKeyword := false;
  palabra := '';

  for i:= 1 to Length(frase) do
  begin
    if frase[i] <> ' ' then
      palabra:= palabra + frase[i]
    else
    begin
      if esKeyword(palabra) then
        contieneKeyword:= true;
      palabra:= '';
    end;
  end;

  if palabra <> '' then
    if esKeyword(palabra) then
      contieneKeyword:= true;
end;

function ExtraerKeywords(frase: string): TStringList;
var
  l: TStringList;
begin
  l := TStringList.Create;
  l.Delimiter := ' ';
  l.DelimitedText := frase;
  Result := l;
end;

end.
