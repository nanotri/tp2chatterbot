unit unit_texto;

interface

type
  TStopWords = array[1..12] of string;

const
  stopwords: TStopWords =
    ('el', 'la', 'los', 'las', 'de', 'del', 'a', 'que', 'por', 'con', 'en', 'un');

function Normalizar(sIn: string): string;
function LimpiarFrase(frase: string): string;

implementation

uses
  SysUtils;

function Normalizar(sIn: string): string;
var
  u: UnicodeString;
  i: integer;
  c: widechar;
  res: string;
begin
  res := '';

  { Pasamos a minusculas y decodificamos UTF-8 a UnicodeString }
  u := UTF8Decode(LowerCase(sIn));

  for i := 1 to Length(u) do
  begin
    c := u[i];

    case c of
      #$00E1, #$00E0, #$00E4, #$00E2, #$00E3: c := 'a';  // á à ä â ã 
      #$00E9, #$00E8, #$00EB, #$00EA: c := 'e';  // é è ë ê 
      #$00ED, #$00EC, #$00EF, #$00EE: c := 'i';  // í ì ï î 
      #$00F3, #$00F2, #$00F6, #$00F4, #$00F5: c := 'o';  // ó ò ö ô õ 
      #$00FA, #$00F9, #$00FC, #$00FB: c := 'u';  // ú ù ü û 
      #$00F1: c := 'n';  // ñ 
    end;

    if ((c >= 'a') and (c <= 'z')) or ((c >= '0') and (c <= '9')) or (c = ' ') then
      res := res + Chr(Ord(c));
    // Chr(Ord(c)) convierte WideChar a Char
  end;

  Normalizar := res;
end;

function EsStopWord(pal: string): boolean;
var
  i: integer;
begin
  EsStopWord := False;
  for i := Low(stopwords) to High(stopwords) do
    if pal = stopwords[i] then
      EsStopWord := True;
end;

function LimpiarFrase(frase: string): string;
var
  i: integer;
  palabra, resultado: string;
begin
  palabra := '';
  resultado := '';

  for i := 1 to Length(frase) do
  begin
    if frase[i] <> ' ' then
      palabra := palabra + frase[i]
    else
    begin
      if (palabra <> '') and (not EsStopWord(palabra)) then
        resultado := resultado + palabra + ' ';
      palabra := '';
    end;
  end;

  if (palabra <> '') and (not EsStopWord(palabra)) then
    resultado := resultado + palabra;

  LimpiarFrase := resultado;
end;

end.
