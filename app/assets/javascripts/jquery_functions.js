$.fn.changeClasses = function(add_classes, remove_classes){
    var classes = this.get(0).classList.toString().split(" ")
    var diff = false
    var new_classes = []

    var classes_to_remove = []
    var classes_to_add = []

    if (!add_classes){
        add_classes = []
    }

    if (!remove_classes){
        remove_classes = []
    }


    if (add_classes.length) {
        for (ac in add_classes) {
            if (!remove_classes.includes(ac) && !classes.includes(ac)) {
                classes_to_add.push(ac)
            }
        }
    }

    if ( remove_classes.length){
        for (rc in remove_classes){
            if (classes.includes(rc)){
                classes_to_remove.push(rc)
            }
        }
    }

    diff = classes_to_add.length > 0 || classes_to_remove.length > 0

    for(c in classes){
        if (!classes_to_remove.includes(c)){

            new_classes.push(c)
        }
    }

    for(c in classes_to_add){
        new_classes.push(c)
    }

    if (diff){
        this.classList = new_classes
    }
}