#!../../bin/linux-x86_64/arroyo

## You may have to change arroyo to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

#Define protocol path
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(ARROYO)/protocol/")




## Register all support components
dbLoadDatabase "dbd/arroyo.dbd"
arroyo_registerRecordDeviceDriver pdbbase

drvAsynIPPortConfigure ("Arroyo1","10.112.63.222:4001",0,0,0)
#asynSetTraceMask("Arroyo1",0,0x07)
#asynSetTraceIOMask("Arroyo1",0,0x07)



## Load record instances
#dbLoadRecords("db/xxx.db","user=zmaHost")
dbLoadRecords("db/arroyo1.db")




#################################################
# autosave

epicsEnvSet IOCNAME bl1a-Arroyo1
epicsEnvSet SAVE_DIR /home/controls/var/$(IOCNAME)


### status-PV prefix, so save_restore can find its status PV's.
save_restoreSet_status_prefix("SECAGE:SE:Arroyo")

set_requestfile_path("$(SAVE_DIR)")
set_savefile_path("$(SAVE_DIR)")

save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(600)
set_pass0_restoreFile("$(IOCNAME).sav")
set_pass0_restoreFile("$(IOCNAME)_pass0.sav")
set_pass1_restoreFile("$(IOCNAME).sav")

#################################################

# Access Security
asSetFilename("$(TOP)/../bl1a-AccessSecurity/db/bl1a.acf")
asSetSubstitutions("P=BL1A:CS")



cd "${TOP}/iocBoot/${IOC}"
iocInit



# Create request file and start periodic 'save'
epicsThreadSleep(5)
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME).req", "autosaveFields")
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME)_pass0.req", "autosaveFields_pass0")
create_monitor_set("$(IOCNAME).req", 5)
create_monitor_set("$(IOCNAME)_pass0.req", 30)


