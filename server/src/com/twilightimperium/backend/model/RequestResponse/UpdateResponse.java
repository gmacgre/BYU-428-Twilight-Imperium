package com.twilightimperium.backend.model.RequestResponse;

import com.twilightimperium.backend.model.update.Update;

public class UpdateResponse {
    Update[] updates;
    //THIS CLASS IS NOT CURRENTLY USED.
    //USE Update[] INSTEAD
    public UpdateResponse(Update[] updates) {
        this.updates = updates;
    }

}
