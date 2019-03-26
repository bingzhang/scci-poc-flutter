/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

package com.uiuc.profile.ui.food_and_merch

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.uiuc.profile.BuildConfig
import com.uiuc.profile.R
import com.venuenext.vncore.VenueNext
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlinx.coroutines.withContext

class FoodAndMerchFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_food_and_merch, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val self = this

        GlobalScope.async {
            try {
                VenueNext.initialize(BuildConfig.FMSdkKey, BuildConfig.FMSdkSecret, self.context!!).await()
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    findNavController().navigate(R.id.action_main_to_stands)
                }
            }

            withContext(Dispatchers.Main) {
                findNavController().navigate(R.id.action_main_to_stands)
            }
        }
    }
}