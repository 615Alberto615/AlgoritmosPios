package com.example.gf12;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.Context;
import android.os.Environment;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.gf12/saveFile";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("saveFile")) {
                                String name = call.argument("name");
                                String content = call.argument("content");
                                try {
                                    boolean success = saveFile(name, content);
                                    result.success(success);
                                } catch (IOException e) {
                                    result.error("ERROR", "Error al guardar el archivo", e.getMessage());
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private boolean saveFile(String name, String content) throws IOException {
        File downloadsDirectory = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
        if (!downloadsDirectory.exists()) {
            if (!downloadsDirectory.mkdirs()) {
                throw new IOException("No se pudo crear el directorio de descargas");
            }
        }

        File file = new File(downloadsDirectory, name);
        try (FileOutputStream fos = new FileOutputStream(file)) {
            fos.write(content.getBytes());
        }

        return true;
    }
}
