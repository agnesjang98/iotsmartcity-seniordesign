# physics engine calculations
# based on the calculations from
# https://www.fhwa.dot.gov/publications/research/infrastructure/structures/bridge/15081/15081.pdf
# for UK
import requests

# ECS  table values
ECS_table = {("A", 1): 1.0, ("B", 1): 1.0, ("C", 1): 1.1, ("D", 1): 1.3, ("E", 1): 1.7,
            ("A", 2): 0, ("B", 2): 2.0, ("C", 2): 2.1, ("D", 1): 2.3, ("E", 1): 2.7,
            ("A", 3): 0, ("B", 3): 3.0, ("C", 3): 3.2, ("D", 1): 3.3, ("E", 1): 3.7,
            ("A", 4): 0, ("B", 4): 4.0, ("C", 4): 4.1, ("D", 1): 4.3, ("E", 1): 4.7,
            ("A", 5): 0, ("B", 5): 5.0, ("C", 5): 5.0, ("D", 5): 5.0, ("E", 5): 5.0,}


# the maximum number of cars that can safely drive over a bridge at any given time
# weight in kg
# maximum amount of cars we can have on our bridge
# max_weight = max_cars*1800

def severity(num_cars):
    max_cars = 96
    max_weight = 96*6000 # 96 * 3 tons  with 30% buffer
    print("max weight: " + str(max_weight))
    avg_car_weight = 4500 # 2 tons is avg weight of cars
    # severity values (ratio from weight of cars)
    # TODO: modify this to use max cars value
    sev_1 = 0 # 0
    sev_2 = int(max_weight/5) 
    sev_3 = sev_2 + int(max_weight/5) 
    sev_4 = sev_3 + int(max_weight/5) 
    sev_5 = sev_4 + int(max_weight/5)
    print("sev_1: %s sev_2: %s sev_3: %s sev_4: %s sev_5: %s max_weight: %s" % (sev_1, sev_2, sev_3, sev_4, sev_5, max_weight))

    # key: # of cars, value: the severity value
    # severities = {sev_1: 1, sev_2: 2, sev_3: 3, sev_4: 4, sev_5: 5}

    # extent - constant depending on bridge age
    # TODO: need to figure out a way to quantify age as a key for determining what age is
    # A, B, C, D, or E
    age = 2
    extent = {0: "A", 1: "B", 2: "C", 3: "D", 4: "E"}

    # first key value for tuple for querying in ECS table
    # constant for one bridge
    bridge_extent = extent[age]

    # STEP 1: retrieve ECS VALUE
    # TODO: modify the severity values based on the weight of cars passing through each point
    cars_at_points = num_cars
    weight_of_cars = cars_at_points*avg_car_weight
    print("weight of cars: " + str(weight_of_cars))
    severity_val = 1
    if weight_of_cars >= sev_1 and weight_of_cars < sev_2:
        severity_val = 1
    elif weight_of_cars >= sev_2 and weight_of_cars < sev_3:
        severity_val = 2
    elif weight_of_cars >= sev_3 and weight_of_cars < sev_4:
        severity_val = 3
    elif weight_of_cars >= sev_4 and weight_of_cars < sev_5:
        severity_val = 4
    # elif weight_of_cars >= sev_5:
    #     severity_val = 5
    elif (weight_of_cars >= sev_5 and weight_of_cars < max_weight) or weight_of_cars > max_weight:
        severity_val = 5
    

    print("severity_val: " + str(severity_val))

    A_severity = severity_val
    B_severity = severity_val
    C_severity = severity_val
    print("severities: " + str(A_severity))

    A_ECS = ECS_table[(bridge_extent, A_severity)] # (C, 2) = 2.1
    B_ECS = ECS_table[(bridge_extent, B_severity)] # (C, 3) = 3.2
    C_ECS = ECS_table[(bridge_extent, C_severity)] # (C, 4) = 4.1

    # print()
    # print("STEP 1")
    # print("A_ECS: " + str(A_ECS))
    # print("B_ECS: " + str(B_ECS))
    # print("C_ECS: " + str(C_ECS))
    # print()

    # STEP 2: retrieve EIF VALUE
    # B - most important (very high)
    # A, C - least important (low)
    # very high = 2, high = 1.5, medium = 1.2, low = 1.0
    A_EIF = 1.0
    B_EIF = 2.0
    C_EIF = 1.0

    # print("STEP 2")
    # print("A_EIF: very low")
    # print("B_EIF: very high")
    # print("C_EIF: very low")
    # print()

    # STEP 3: ECF calculation
    # ECF for high = 0.3 - [(pointB_ECS - 1)*(0.3/4)] 
    B_ECF = 0.3 - (B_ECS - 1)*(0.3/4)

    # ECF for low = 1.2 - [(pointA,C_ECS - 1)*(1.2/4)] 
    A_ECF = 0.3 - (A_ECS - 1)*(1.2/4)
    C_ECF = 0.3 - (C_ECS - 1)*(1.2/4)

    # print("STEP 3")
    # print("A_ECF: " + str(A_ECF))
    # print("B_ECF: " + str(B_ECF))
    # print("C_ECF: " + str(C_ECF))
    # print()

    # STEP 4: ECI calculation
    # ECI = ECS - ECF
    A_ECI = A_ECS - A_ECF
    B_ECI = B_ECS - B_ECF
    C_ECI = C_ECS - C_ECF

    # print("STEP 4")
    # print("A_ECI: " + str(A_ECI))
    # print("B_ECI: " + str(B_ECI))
    # print("C_ECI: " + str(C_ECI))
    # print()

    # STEP 5: BCS calculation
    # for N = 3 bridge elements (summation)
    BCS_top = (A_ECI*A_EIF) + (B_ECI*B_EIF) + (C_ECI*C_EIF)
    BCS_bot = A_EIF + B_EIF + C_EIF
    BCS = BCS_top/BCS_bot

    # print("STEP 5")
    # print("BCS: " + str(BCS))
    # print()

    # STEP 6: BCI calculation
    print("100 - " + str((2 * (pow(BCS, 2) + (6.5 * BCS) - 7.5))))
    BCI = 100 - (2 * (pow(BCS, 2) + (6.5 * BCS) - 7.5))
    # print("STEP 5")
    print("BCI: " + str(BCI))
    print()

    url = "https://smart-city-266807.appspot.com/bci"
    data = {"id": "0", "bci": BCI, "latitude": 33.657033, "longitude": -117.847138}
    r = requests.post(url = url, json = data)
    # print(r.content)