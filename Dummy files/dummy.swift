 DispatchQueue.global(qos: .userInitiated).async {
    // Do some time consuming task in this background thread
    // Mobile app will remain to be responsive to user actions
    
    print("Performing time consuming task in this background thread")
    
   DispatchQueue.main.async {
        // Task consuming task has completed
        // Update UI from this block of code
        print("Time consuming task has completed. From here we are allowed to update user interface.")
    }
}
