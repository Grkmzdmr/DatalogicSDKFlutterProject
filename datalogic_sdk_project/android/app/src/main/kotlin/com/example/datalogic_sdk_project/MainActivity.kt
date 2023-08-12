package com.example.datalogic_sdk_project

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import com.datalogic.device.input.KeyboardManager
import io.flutter.embedding.android.KeyData.CHANNEL
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.datalogic.device.input.AutoScanTrigger.Range
import com.datalogic.device.input.Trigger
import com.datalogic.device.input.AutoScanTrigger
import com.datalogic.device.info.SYSTEM
import com.datalogic.device.battery.BatteryStatus
import com.datalogic.device.battery.DLBatteryManager
import com.datalogic.device.battery.ManufacturerInfo


class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutter.native/helper"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "scannerOpenOff") {
                scannerOpenOff()
          
            }else if (call.method == "getDeviceInfo"){
                result.success(com.datalogic.device.info.SYSTEM.SERIAL_NUMBER)
            }else if(call.method == "autoScannerClose"){
                autoScannerClose()
            }
           
            else {
                scannerOpen()

            }
           
            
        }
    }

    private fun scannerOpenOff() {
        
        val keyManager = KeyboardManager()
        for (trigger in keyManager.availableTriggers) {
            trigger.setEnabled(false)

          
        }
    }


    private fun autoScannerClose() {
        val keyManager = KeyboardManager()
        val lt: List<Trigger> = keyManager.getAvailableTriggers()
        for (tr: Trigger in lt) {
             if (tr.getId() == KeyboardManager.TRIGGER_ID_AUTOSCAN) {
               //AutoScanTrigger as = (AutoScanTrigger) tr
                //val autoScanner = AutoScanTrigger()
                 tr.setEnabled(false);
                  //   as.setEnabled(true)

            }


        }
    }


  

    private fun scannerOpen() {

        val keyManager = KeyboardManager()
        //İşlemi yaparkan zaman kaybı yaşamamak adına sadece en öndeki triggerı aktif ediyorum.
        val lt: List<Trigger> = keyManager.getAvailableTriggers()
        for (tr: Trigger in lt) {
            if (tr.getId() == KeyboardManager.TRIGGER_ID_FRONT) {
             
                tr.setEnabled(true);
               

            }


        }
    }
}
