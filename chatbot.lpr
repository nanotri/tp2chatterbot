program chatbot;

{$codepage utf8}
uses
  crt,
  unit_texto,
  unit_respuestas,
  unit_archivos;

var
  pregunta: string;
  terminar: boolean;

begin
  terminar := False;

  writeln('ChatterBot');
  repeat
    writeln(' ');
    readln(pregunta);

    pregunta := Normalizar(pregunta);

    if BuscarEnArchivoTexto('saludos.txt', pregunta) then
      writeln('Bienvenido. Indique la tarea a realizar.')
    else if BuscarEnArchivoTexto('despedidas.txt', pregunta) then
    begin
      writeln('Hasta luego. Que tenga un buen día.');
      ReadKey;
      terminar := True;
    end
    else
    begin
      ResponderPregunta(pregunta);
    end;

  until terminar = True;
end.
