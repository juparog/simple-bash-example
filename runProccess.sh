############ definir variables de entorno ############
export WORK_DIRECORY="./"
#### fin de la definicion de variables de entorno ####

# Ubicarse en el directorio de trabajo
cd $WORK_DIRECORY

# Parametro id del flujo a ejecutar
ID_WF=$1

# Obtener datos del proceso a ejecutar a partir del parametro de entrada
echo $(python -c 'import json,sys;obj=json.load(open("'$WORK_DIRECORY'/list_workflows.json"));print(obj["'$ID_WF'"]["wfName"], obj["'$ID_WF'"]["user"], obj["'$ID_WF'"]["date"])';) > $WORK_DIRECORY/$ID_WF.txt

# argar los parametros dl wf destino a ejecutar
params=$(< $WORK_DIRECORY/$ID_WF.txt)

echo $params $? | tee -a $WORK_DIRECORY/$ID_WF.txt

wf_name=`echo $params | awk -F ' ' '{print $1}'`
user=`echo $params | awk -F ' ' '{print $2}'`
date_exec=`echo $params | awk -F ' ' '{print $3}'`

# Ejecutar flujo finalo con parametros (test)
echo './shellFinal.sh '$wf_name' '$user' '$date_exec''