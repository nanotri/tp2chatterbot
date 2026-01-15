unit unitsaludos;

{$mode ObjFPC}{$H+}

interface
function Saludar(preg: string): boolean;
function Despedir(preg: string): boolean;

implementation

function buscarArch(nomArch, texto: string): boolean;
var
  arch: Text;
  linea: string;
  v: boolean;
begin
  buscarArch := false;
  v:= true;

  Assign(arch, nomArch);

  {$I-}
  Reset(arch);
  {$I+}

  if IOResult <> 0 then
    v:= false;

  if v then
  begin
    while not EOF(arch) do
    begin
      ReadLn(arch, linea);
      if texto = linea then
        buscarArch := true;
    end;
    Close(arch);
  end;
end;


function Saludar(preg: string):boolean;
begin
  Saludar:= buscarArch('saludos.text', preg);
end;

function Despedir(preg: string): boolean;
begin
  Despedir:= buscarArch('despedidas.text', preg);
end;

end.
