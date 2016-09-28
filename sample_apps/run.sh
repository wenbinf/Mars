#!/bin/sh
#$Id: run.sh 740 2009-11-13 16:17:34Z wenbinor $

#===========================================================
#user defined variables
#===========================================================

#-----------------------------------------------------------
# without a slash in the tail of the two paths
#-----------------------------------------------------------

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#you must setup correct $SDK_PATH
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#SDK_PATH="$HOME/CUDA_SDK"
SDK_PATH="/home/wenbin/CUDA_SDK"

SDK_BIN_PATH="$SDK_PATH/C/bin/linux/release"
SDK_SRC_PATH="$SDK_PATH/C/sample_apps"

BIN_TMPL_PATH=$SDK_SRC_PATH/BIN_TMPL

SS_BIN_DIR=$SDK_BIN_PATH/SimilarityScore
SM_BIN_DIR=$SDK_BIN_PATH/StringMatch
II_BIN_DIR=$SDK_BIN_PATH/InvertedIndex
PVC_BIN_DIR=$SDK_BIN_PATH/PageViewCount
PVR_BIN_DIR=$SDK_BIN_PATH/PageViewRank
MM_BIN_DIR=$SDK_BIN_PATH/MatrixMul
WC_BIN_DIR=$SDK_BIN_PATH/WordCount
KM_BIN_DIR=$SDK_BIN_PATH/Kmeans

SS_SRC_DIR=$SDK_SRC_PATH/SimilarityScore
SM_SRC_DIR=$SDK_SRC_PATH/StringMatch
II_SRC_DIR=$SDK_SRC_PATH/InvertedIndex
PVC_SRC_DIR=$SDK_SRC_PATH/PageViewCount
PVR_SRC_DIR=$SDK_SRC_PATH/PageViewRank
MM_SRC_DIR=$SDK_SRC_PATH/MatrixMul
WC_SRC_DIR=$SDK_SRC_PATH/WordCount
KM_SRC_DIR=$SDK_SRC_PATH/Kmeans

USAGE="usage: run.sh [make|run] [all|ss|sm|mm|pvc|pvr|ii|wc|km]"
STR_MAKE="making source code..."
STR_RUN="running test suite..."
STR_MAKE_SS="making Similarity Score source code..."
STR_MAKE_SM="making String Match source code..."
STR_MAKE_MM="making MatrixMul source code..."
STR_MAKE_PVC="making PageViewCount source code..."
STR_MAKE_PVR="making PageViewRank source code..."
STR_MAKE_ALL="making all source code..."
STR_MAKE_II="making InvertedIndex source code..."
STR_MAKE_WC="making WordCount source code..."
STR_MAKE_KM="making Kmeans source code..."

#===========================================================
#user defined functions
#===========================================================

function MakeSrc()
{
	if [ ! -d $1 ]
	then
		echo "$1 doesn't exist, mkdir it..."
		mkdir $1
	fi

	echo "enter $2, making..."
	cd $2
	sh make.sh
	echo "made successfully"
}

#check the number of command line arguments
if [ $# -lt 2 ]
then
	echo $USAGE
	exit
fi

#run the test suite
if [ "$1" = "run" ]
then
	echo $STR_RUN

	case $2 in
		"ss")
			cp -r $BIN_TMPL_PATH/SS_BIN/* $SS_BIN_DIR/
			cd $SS_BIN_DIR
			sh run.sh
			;;
		"sm")
			cp -r $BIN_TMPL_PATH/SM_BIN/* $SM_BIN_DIR/
			cd $SM_BIN_DIR
			sh run.sh
			;;
		"mm")
			cp -r $BIN_TMPL_PATH/MM_BIN/* $MM_BIN_DIR/
			cd $MM_BIN_DIR
			sh run.sh
			;;
		"ii")
			cp -r $BIN_TMPL_PATH/II_BIN/* $II_BIN_DIR/
			cd $II_BIN_DIR
			sh run.sh
			;;
		"pvc")
			cd $BIN_TMPL_PATH/GenWebLogSrc
			make clean 
			make
			cp Gen ../PVC_BIN
			cp ../PVC_BIN/* $PVC_BIN_DIR/
			chmod 777 $PVC_BIN_DIR/Gen
			cd $PVC_BIN_DIR
			sh run.sh
			;;
		"pvr")
			cd $BIN_TMPL_PATH/GenWebLogSrc
			make clean
			make
			cp Gen ../PVR_BIN
			cp ../PVR_BIN/* $PVR_BIN_DIR/
			chmod 777 $PVR_BIN_DIR/Gen
			cd $PVR_BIN_DIR
			sh run.sh
			;;
		"wc")
			cp -r $BIN_TMPL_PATH/WC_BIN/* $WC_BIN_DIR/
			cd $WC_BIN_DIR
			sh run.sh
			;;
		"km")
			cp -r $BIN_TMPL_PATH/KM_BIN/* $KM_BIN_DIR/
			cd $KM_BIN_DIR
			sh run.sh
			;;
		"all")
			echo "==========Similarity Score========="
			cp -r $BIN_TMPL_PATH/SS_BIN/* $SS_BIN_DIR/
			cd $SS_BIN_DIR
			sh run.sh

			echo "==========StringMatch========="
			cp -r $BIN_TMPL_PATH/SM_BIN/* $SM_BIN_DIR/
			cd $SM_BIN_DIR
			sh run.sh

			echo "==========MatrixMul========="
			cp -r $BIN_TMPL_PATH/MM_BIN/* $MM_BIN_DIR/
			cd $MM_BIN_DIR
			sh run.sh

			echo "==========InvertdIndex========="
			cp -r $BIN_TMPL_PATH/II_BIN/* $II_BIN_DIR/
			cd $II_BIN_DIR
			sh run.sh

			echo "==========PageViewCount========="
			cd  $BIN_TMPL_PATH/GenWebLogSrc
			make clean
			make
			cp Gen ../PVC_BIN
			cp ../PVC_BIN/* $PVC_BIN_DIR/
			chmod 777 $PVC_BIN_DIR/Gen
			cd $PVC_BIN_DIR
			sh run.sh

			echo "==========PageViewRank========="
			cd  $BIN_TMPL_PATH/GenWebLogSrc
			make clean
			make
			cp Gen ../PVR_BIN
			cp ../PVR_BIN/* $PVR_BIN_DIR/
			chmod 777 $PVR_BIN_DIR/Gen
			cd $PVR_BIN_DIR
			sh run.sh

			echo "==========WordCount========="
			cp -r $BIN_TMPL_PATH/WC_BIN/* $WC_BIN_DIR/
			cd $WC_BIN_DIR
			sh run.sh

			echo "==========Kmeans========="
			cp -r $BIN_TMPL_PATH/KM_BIN/* $KM_BIN_DIR/
			cd $KM_BIN_DIR
			sh run.sh

			;;
		*)
			echo $USAGE
			exit
			;;
	esac
#make source code
elif [ "$1" = "make" ]
then
	echo $STR_MAKE

	case $2 in
		"ss")
			echo $STR_MAKE_SS
			MakeSrc $SS_BIN_DIR $SS_SRC_DIR
			;;
		"sm")
			echo $STR_MAKE_SM
			MakeSrc $SM_BIN_DIR $SM_SRC_DIR
			;;
		"mm")
			echo $STR_MAKE_SM
			MakeSrc $MM_BIN_DIR $MM_SRC_DIR
			;;
		"pvc")
			echo $STR_MAKE_SM
			MakeSrc $PVC_BIN_DIR $PVC_SRC_DIR
			;;
		"pvr")
			echo $STR_MAKE_SM
			MakeSrc $PVR_BIN_DIR $PVR_SRC_DIR
			;;
		"ii")
			echo $STR_MAKE_SM
			MakeSrc $II_BIN_DIR $II_SRC_DIR
			;;
		"wc")
			echo $STR_MAKE_WC
			MakeSrc $WC_BIN_DIR $WC_SRC_DIR
			;;
		"km")
			echo $STR_MAKE_KM
			MakeSrc $KM_BIN_DIR $KM_SRC_DIR
			;;
		"all")
			echo $STR_MAKE_ALL
			MakeSrc $SS_BIN_DIR $SS_SRC_DIR
			MakeSrc $SM_BIN_DIR $SM_SRC_DIR
			MakeSrc $MM_BIN_DIR $MM_SRC_DIR
			MakeSrc $PVC_BIN_DIR $PVC_SRC_DIR
			MakeSrc $PVR_BIN_DIR $PVR_SRC_DIR
			MakeSrc $II_BIN_DIR $II_SRC_DIR
			MakeSrc $WC_BIN_DIR $WC_SRC_DIR
			MakeSrc $KM_BIN_DIR $KM_SRC_DIR
			echo "all done"
			;;
		*)
			echo $USAGE
			exit
			;;
	esac

#clean object files
elif [ "$1" = "clean" ]
then
	echo "clean obj files..."
	case $2 in
		"ss")
			rm -r $SS_SRC_DIR/obj
			;;
		"sm")
			rm -r $SM_SRC_DIR/obj
			;;
		"ii")
			rm -r $II_SRC_DIR/obj
			;;
		"mm")
			rm -r $MM_SRC_DIR/obj
			;;
		"pvc")
			rm -r $PVC_SRC_DIR/obj
			;;
		"pvr")
			rm -r $PVR_SRC_DIR/obj
			;;
		"wc")  
			rm -r $WC_SRC_DIR/obj
			;;
		"km")  
			rm -r $KM_SRC_DIR/obj
			;;
		"all")
			rm -r $SS_SRC_DIR/obj
			rm -r $SM_SRC_DIR/obj
			rm -r $II_SRC_DIR/obj
			rm -r $MM_SRC_DIR/obj
			rm -r $PVC_SRC_DIR/obj
			rm -r $PVR_SRC_DIR/obj
			rm -r $WC_SRC_DIR/obj
			rm -r $KM_SRC_DIR/obj
			;;
		*)
			echo $USAGE
			;;
	esac

#wrong arguments
else
	echo $USAGE
fi
