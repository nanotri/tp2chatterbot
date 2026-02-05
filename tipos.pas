
unit tipos;
interface

type
  T_FECHA = record
    Dia: 1..31;
    Mes: 1..12;
    Anio: integer;
  end;

  T_String50 = string

    [50];
  T_String100 = string

    [100];
  T_String9 = string

    [9];
  T_String10 = string

    [10];
  T_String5 = string

    [5];
  T_String2 = string

    [2];

  T_Cant_Area = array[1..5] of integer;
  T_ARRAY_DOCENTES = array[1..4] of T_String100;

  T_DATO_CAPACITACIONES = record
    Codigo: integer;
    Nombre: T_String50;
    FechaInicio: T_FECHA;
    FechaFin: T_FECHA;
    Tipo: 1..3;
    //(1-curso - 2-taller - 3-seminario)
    CantidadHoras: real;
    Docentes: T_ARRAY_DOCENTES;
    CantidadInscriptos: integer;
    Area: 1..5;
    //(1-ISI – 2-LOI – 3-Civil – 4-Electro - 5-General)
    Estado: boolean;
  end;

  T_DATO_ALUMNOS = record
    Codigo: integer;
    DNI: T_String9;
    ApyNom: T_String100;
    FechaNacimiento: T_FECHA;
    DocenteUTN: boolean;
    Condicion: boolean;
    // True: Aprobado - False: Asistencia
    Estado: boolean;
  end;
  T_ARCHIVO_CAP = file of T_DATO_CAPACITACIONES;
  T_ARCHIVO_ALU = file of T_DATO_ALUMNOS;

  T_DATO_ARBOL = record
    clave: string;
    pos_arch: integer;
  end;
  T_PUNT = ^T_NODO;

  T_NODO = record
    INFO: T_DATO_ARBOL;
    SAI, SAD: T_PUNT;
  end;

  T_PUNT_LISTA_SOC = ^T_NODO_LISTA_SOC;

  T_NODO_LISTA_SOC = record
    INFO: T_DATO_CAPACITACIONES;
    SIG: T_PUNT_LISTA_SOC;
  end;

  T_LISTA_SOC = record
    CAB, ACT: T_PUNT_LISTA_SOC;
    TAM: integer;
  end;

implementation

begin
end.
