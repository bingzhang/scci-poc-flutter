/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

package com.uiuc.profile.ui.food_and_merch

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import com.uiuc.profile.R

class FoodAndMerchActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_food_and_merch)
    }

    /**
     * Manually bring the user back from android content to flutter content
     */
    override fun onBackPressed() {
        val fmHomeFragmentId = R.id.standsFragment
        val currentDestId = findNavController(R.id.fragment_food_and_merch).currentDestination?.id
        if (currentDestId == fmHomeFragmentId) {
            finish()
        } else {
            super.onBackPressed()
        }
    }
}