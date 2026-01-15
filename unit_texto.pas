unit unit_texto;

interface

function Normalizar(s: string): string;
function LimpiarFrase(frase: string): string;


implementation

uses
SysUtils,
Classes ;

function Normalizar(s: string): string;
var
  i: integer;
  resultado: string;
begin
  resultado := '';
  s:= LowerCase(s);

  for i := 1 to Length(s) do
    if s[i] in ['a'..'z', '0'..'9', ' '] then
      resultado := resultado + s[i];
  Normalizar:= resultado;
end;

function LimpiarFrase(frase: string): string;
const
  stopwords: array[1..12] of string =
    ('el','la','los','las','de','del','a','que','por','con','en','un');
var
  palabras: TStringList;
  i, k: integer;
  esStop, encontrado: boolean;
begin
  frase := LowerCase(frase);
  palabras := TStringList.Create;
  palabras.Delimiter := ' ';
  palabras.DelimitedText := frase;

  Result := '';

  for i := 0 to palabras.Count - 1 do
  begin
    esStop := False;
    encontrado := False;
    k := Low(stopwords);

    while (k <= High(stopwords)) and (not encontrado) do
    begin
      if palabras[i] = stopwords[k] then
      begin
        esStop := True;
        encontrado := True;
      end;
      Inc(k);
    end;

    if not esStop then
      Result := Result + palabras[i] + ' ';
  end;

  palabras.Free;
end;


end.

