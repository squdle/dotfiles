        # Place this in class __init__ (must be using modern classes)
        self._!!property_name!! = !!property_default_value!!

    @property
    def !!property_name!!(self):
        """ Get or set !!property_name!! - !!property description!!."""
        return self._!!property_name!!
    
    @!!property_name!!.setter
    def !!property_name!!(self, value):
        self._!!property_name!! = value

    @!!property_name!!.deleter
    def !!property_name!!(self):
        !!delete statement(s)!!
