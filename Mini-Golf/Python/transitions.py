
class endTransition:
    ongoing = False
    switched = False
    radius = 25
    opacity = 255
    oldPos = PVector(0,0)
    
    def reset(self):
        self.ongoing = False
        self.switched = False
        self.radius = 25
        self.opacity = 255
        
class resetTransition:
    ongoing = False
    radius1 = 25
    radius2 = 100
    opacity1 = 255
    opacity2 = 0
    oldPos = PVector(0,0)
    
    def reset(self):
        self.ongoing = False
        self.radius1 = 25
        self.opacity1 = 255
        self.radius2 = 100
        self.opacity2 = 0
        self.oldPos = PVector(500,700)
    
