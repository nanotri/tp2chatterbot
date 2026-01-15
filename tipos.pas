Unit tipos;

Interface

Type
  T_FECHA = Record
    Dia: 1..31;
    Mes: 1..12;
    Anio: integer;
  End;

  T_String50 = String[50];
  T_String100 = String[100];
  T_String9 = string[9];
  T_String10 = string[10];
  T_String5 = string[5];
  T_String2 = string[2];

  T_ARRAY_DOCENTES = array[1..10] Of T_String100;
  T_DATO_CAPACITACIONES = Record
    Codigo: integer;
    Nombre: T_String50;
    FechaInicio: T_FECHA;
    FechaFin: T_FECHA;
    Tipo: 1..3;
    //(1-curso - 2-taller - 3-seminario)
    CantidadHoras: integer;
    CantidadDocentes: 1..10;
    Docentes: T_ARRAY_DOCENTES;
    CantidadInscriptos: integer;
    Area: 1..5;
    //(1-ISI – 2-LOI – 3-Civil – 4-Electro - 5-General)
    Estado: Boolean;
  End;

  T_DATO_ALUMNOS = Record
    Codigo: integer;
    DNI: T_String9;
    ApyNom: T_String100;
    FechaNacimiento: T_FECHA;
    DocenteUTN: Boolean;
    Condicion: Boolean;
    // True: Aprobado - False: Asistencia
    Estado: Boolean;
  End;
  T_ARCHIVO_CAP = FILE Of T_DATO_CAPACITACIONES;
  T_ARCHIVO_ALU = FILE Of T_DATO_ALUMNOS;
  T_DATO_ARBOL = Record
    clave: string;
    pos_arch: integer;
  End;
  T_PUNT = ^T_NODO;
  T_NODO = Record
    INFO: T_DATO_ARBOL;
    SAI, SAD: T_PUNT;
  End;

Implementation

Begin
End.

