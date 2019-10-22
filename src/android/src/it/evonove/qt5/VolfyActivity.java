package it.evonove.qt5;

import it.evonove.volfyirion.R;
import android.app.Activity;
import android.os.Bundle;
import android.os.VibrationEffect;
import android.os.Vibrator;
import android.content.Context;
import android.os.Build;

import android.support.v4.content.ContextCompat;
import android.support.v4.app.ActivityCompat;
import android.Manifest;
import android.content.pm.PackageManager;
import android.widget.Toast;
import android.media.MediaScannerConnection;
import android.net.Uri;

public class VolfyActivity extends org.qtproject.qt5.android.bindings.QtActivity
{
    static final int PERMISSION_WRITE_EXTERNAL_STORAGE = 0;
     private static VolfyActivity m_instance;

    public VolfyActivity()
    {
        // here we override the default theme with our own
        // which allows us to set status bar color and
        // notification bar color
        QT_ANDROID_THEMES = new String[] {"VolfyTheme"};
        QT_ANDROID_DEFAULT_THEME = "VolfyTheme";
        m_instance = this;
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        setTheme(R.style.VolfyTheme);
        super.onCreate(savedInstanceState);
    }

    public void vibrate() {
        // Check android SDK version to call correct vibrate functions
        // For android API level > 25
        if(android.os.Build.VERSION.SDK_INT > android.os.Build.VERSION_CODES.N_MR1){
            ((Vibrator) getSystemService(Context.VIBRATOR_SERVICE)).vibrate(VibrationEffect.createOneShot(500, 255));
        }
        else {
        // For android API level <= 25
            ((Vibrator) getSystemService(Context.VIBRATOR_SERVICE)).vibrate(500);
        }
    }

    public static void scanFile(String path) {
        System.out.println("scanFile");
        MediaScannerConnection.scanFile(m_instance,
            new String[] { path }, null,
            new MediaScannerConnection.OnScanCompletedListener() {
                public void onScanCompleted(String path, Uri uri) {
                    // No need to do anything on file actually scanned or not
                }
            }
        );
    }

}
