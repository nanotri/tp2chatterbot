unit unit_levenshtein;

interface

function DistanciaLevenshtein(s1, s2: string): integer;

implementation

function Min(a, b, c: integer): integer;
begin
  Min := a;
  if b < Min then
    Min := b;
  if c < Min then
    Min := c;
end;

function DistanciaLevenshtein(s1, s2: string): integer;
var
  i, j: integer;
  d: array[0..50, 0..50] of integer;
begin
  for i := 0 to Length(s1) do
    d[i, 0] := i;

  for j := 0 to Length(s2) do
    d[0, j] := j;

  for i := 1 to Length(s1) do
    for j := 1 to Length(s2) do
      if s1[i] = s2[j] then
        d[i, j] := d[i - 1, j - 1]
      else
        d[i, j] := 1 + Min(d[i - 1, j], d[i, j - 1], d[i - 1, j - 1]);

  DistanciaLevenshtein := d[Length(s1), Length(s2)];
end;

end.
