package com.example.cloud_messaging

import android.os.Bundle
import android.widget.Toast
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        checkGooglePlayServices()
    }

    override fun onResume() {
        super.onResume()

        checkGooglePlayServices()
    }

    private fun checkGooglePlayServices() {
        val apiAvailability = GoogleApiAvailability.getInstance()
        val resultCode = apiAvailability.isGooglePlayServicesAvailable(this)

        if (resultCode != ConnectionResult.SUCCESS) {
            if (apiAvailability.isUserResolvableError(resultCode)) {
                apiAvailability
                    .makeGooglePlayServicesAvailable(this)
                    .addOnSuccessListener { }
                    .addOnFailureListener {
                        val dialog = apiAvailability.getErrorDialog(
                            this,
                            resultCode,
                            9000,
                        ) {
                            finish()
                        }

                        dialog?.show()
                    }
            } else {
                Toast
                    .makeText(
                        this,
                        "Your device is not supported with Google Play services.",
                        Toast.LENGTH_LONG,
                    )
                    .show()

                finish()
            }
        }
    }
}

