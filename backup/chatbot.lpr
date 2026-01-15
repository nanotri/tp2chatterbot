program chatbot;
uses
  crt,
  unit_texto,
  unitsaludos,
  unit_respuestas;

var
  pregunta: string;
  terminar: boolean;

begin
  terminar:= false;

  writeln('ChatterBot');
repeat
    writeln(' ');
    readln(pregunta);

    pregunta:= Normalizar(pregunta);

    if Saludar(pregunta) then
    begin
     writeln('Hola. ¿En qué trabajamos hoy?');
    end
    else
    if Despedir(pregunta) then
    begin
     writeln('Hasta luego. Que tengas una jornada productiva.');
     readkey;
     terminar:= true;
    end
    else
   begin
     ResponderPregunta(pregunta);
   end;

until terminar = true;
end.
