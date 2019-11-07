class Coordinate():
    def __init__(self, latitude, longitude):
        self.latitude = latitude
        self.longitude = longitude

    def getJSON(self):
        return {"latitude": self.latitude, "longitude": self.longitude}
