//
//  Tips.swift
//  foresite
//
//  Created by David Cheng on 9/8/18.
//  Copyright © 2018 2DGB. All rights reserved.
//

import Foundation

struct Tips {
    //    key:    diaster type
    //    value:  [before tips, during tips, after tips, link]
    static let tips = [
        "Earthquake": [
            """
                -Secure items, such as televisions, and objects that hang on walls. Store heavy and breakable objects on low shelves.
                -Practice Drop, Cover, then Hold On with family and coworkers. Drop to your hands and knees. Cover your head and neck with your arms. Crawl only as far as needed to reach cover from falling materials. Hold on to any sturdy furniture until the shaking stops.
                -Create a family emergency communications plan that has an out-of-state contact. Plan where to meet if you get separated.
                -Make a supply kit that includes enough food and water for at least three days, a flashlight, a fire extinguisher, and a whistle. Consider each person’s specific needs, including medication. Do not forget the needs of pets. Have extra batteries and charging devices for phones and other critical equipment.
                -Consider obtaining an earthquake insurance policy. Standard homeowner’s insurance does not cover earthquake damage.
                -Consider a retrofit of your building to correct structural issues that make it vulnerable to collapse during an earthquake.
            """,
            """
                -Drop, Cover, and Hold On. Drop to your hands and knees. Cover your head and neck with your arms. Hold on to any sturdy furniture until the shaking stops. Crawl only if you can reach better cover without going through an area with more debris.
                -DO NOT run outside
                -If in a vehicle, stop in a clear area that is away from buildings, trees, overpasses, underpasses, or utility wires.
                -If you are in a high-rise building, expect fire alarms and sprinklers to go off. Do not use elevators.
                -If near slopes, cliffs, or mountains, be alert for falling rocks and landslides.
            """,
            
            """
                -Expect aftershocks to follow the largest shock of an earthquake.
                -If in a damaged building, go outside and quickly move away from the building. Do not enter damaged buildings.
                -If you are trapped, cover your mouth. Send a text, bang on a pipe or wall, or use a whistle instead of shouting so that rescuers can locate you.
                -Save phone calls for emergencies.
                -Once safe, monitor local news reports via battery operated radio, TV, social media, and cell phone text alerts for emergency information and instructions.
                -Use extreme caution during post-disaster clean-up of buildings and around debris. Do not attempt to remove heavy debris by yourself. Wear protective clothing, including a long-sleeved shirt, long pants, work gloves, and sturdy, thick-soled shoes during clean-up.
            """,
            """
                Information from:
                https://www.ready.gov/earthquakes
            """
        ],
        "Fire": [
            """
                -Sign up for your community’s warning system. The Emergency Alert System (EAS) and National Oceanic and Atmospheric Administration (NOAA) Weather Radio also provide emergency alerts.
                -Know your community’s evacuation plans and find several ways to leave the area. Drive the evacuation routes and find shelter locations. Have a plan for pets and livestock.
                -Gather emergency supplies, including N95 respirator masks that filter out particles in the air you breathe. Keep in mind each person’s specific needs, including and updated asthma action plan and medication. Don’t forget the needs of pets.
                -Designate a room that can be closed off from outside air. Close all doors and windows. Set up a portable air cleaner to keep indoor pollution levels low when smoky conditions exist.
                -Keep important documents in a fireproof, safe place. Create password-protected digital copies.
                -Use fire-resistant materials to build, renovate, or make repairs.
                -Find an outdoor water source with a hose that can reach any area of your property.
                -Create a fire-resistant zone that is free of leaves, debris, or flammable materials for at least 30 feet from your home.
                -Review insurance coverage to make sure it is enough to replace your property.
                -Pay attention to air quality alerts.

            """,
            """
                -Evacuate immediately if authorities tell you to do so.
                -If trapped, then call 911 and give your location, but be aware that emergency response could be delayed or impossible. Turn on lights to help rescuers find you.
                -Listen to EAS, NOAA Weather Radio, or local alerting systems for current emergency information and instructions.
                -Use an N95 masks to keep harmful particles out of the air you breathe.
                -If you are not ordered to evacuate but smoky conditions exist, stay inside in a safe location or go to a community building where smoke levels are lower.
            """,
            """
                -Listen to authorities to find out when it is safe to return, and whether water is safe to drink.
                -Avoid hot ash, charred trees, smoldering debris, and live embers. The ground may contain heat pockets that can burn you or spark another fire. Consider the danger to pets and livestock.
                -Send text messages or use social media to reach out to family and friends. Phone systems are often busy following a disaster. Make calls only in emergencies.
                -Wear a NIOSH certified-respirator dust mask and wet debris down to minimize breathing dust particles.
                -Document property damage with photographs. Conduct an inventory and contact your insurance company for assistance.
                -Wildfires dramatically change landscape and ground conditions, which can lead to increased risk of flooding due to heavy rains, flash flooding and mudflows. Flood risk remains significantly higher until vegetation is restored—up to 5 years after a wildfire. Consider purchasing flood insurance to protect the life you've built and to assure financial protection from future flooding.
            """,
            """
                Information from:
                https://www.ready.gov/wildfires
            """
        ],
        "Flood": [
            """
                -Know types of flood risk in your area. Visit FEMA’s Flood Map Service Center for information.
                -Sign up for your community’s warning system. The Emergency Alert System (EAS) and National Oceanic and Atmospheric Administration (NOAA) Weather Radio also provide emergency alerts.
                -If flash flooding is a risk in your location, then monitor potential signs, such as heavy rain.
                -Learn and practice evacuation routes, shelter plans, and flash flood response.
                -Gather supplies in case you have to leave immediately, or if services are cut off. Keep in mind each person’s specific needs, including medication. Don’t forget the needs of pets. Obtain extra batteries and charging devices for phones and other critical equipment.
                -Purchase or renew a flood insurance policy. It typically takes up to 30 days for a policy to go into effect and can protect the life you've built. Homeowner’s policies do not cover flooding. Get flood coverage under the National Flood Insurance Program (NFIP)
                -Keep important documents in a waterproof container. Create password-protected digital copies.
                -Protect your property. Move valuables to higher levels. Declutter drains and gutters. Install check valves. Consider a sump pump with a battery.
            """,
            """
                -Depending on where you are, and the impact and the warning time of flooding, go to the safe location that you previously identified.
                -If told to evacuate, do so immediately. Never drive around barricades. Local responders use them to safely direct traffic out of flooded areas.
                -Listen to EAS, NOAA Weather Radio, or local alerting systems for current emergency information and instructions.
                -Do not walk, swim, or drive through flood waters. Turn Around. Don’t Drown!
                -Stay off bridges over fast-moving water. Fast-moving water can wash bridges away without warning.
                -If your vehicle is trapped in rapidly moving water, then stay inside. If water is rising inside the vehicle, then seek refuge on the roof.
                -If trapped in a building, then go to its highest level. Do not climb into a closed attic. You may become trapped by rising floodwater. Go on the roof only if necessary. Once there, signal for help.
            """,
            """
                -Listen to authorities for information and instructions. Return home only when authorities say it is safe.
                -Avoid driving, except in emergencies.
                -Snakes and other animals may be in your house. Wear heavy gloves and boots during clean up.
                -Be aware of the risk of electrocution. Do not touch electrical equipment if it is wet or if you are standing in water. If it is safe to do so, turn off the electricity to prevent electric shock.
                -Avoid wading in floodwater, which can contain dangerous debris and be contaminated. Underground or downed power lines can also electrically charge the water.
                -Use a generator or other gasoline-powered machinery ONLY outdoors and away from windows.
            """,
            """
                Information from:
                https://www.ready.gov/floods
            """
        ],
        "Tsunami": [
                """
                    -If you live near, or regularly visit a coastal area, learn about the risk of tsunami in the area. Some at-risk communities have maps with evacuation zones and routes. If you are a visitor, ask about community plans.
                    -Learn the signs of a potential tsunami, such as an earthquake, a loud roar from the ocean, or unusual ocean behavior, such as a sudden rise or wall of water or sudden draining of water showing the ocean floor.
                    -Know and practice community evacuation plans and map out your routes from home, work, and play. Pick shelters 100 feet or more above sea level, or at least one mile inland.
                    -Create a family emergency communication plan that has an out-of-state contact. Plan where to meet if you get separated.
                    -Sign up for your community’s warning system. The Emergency Alert System (EAS) and National Oceanic and Atmospheric Administration (NOAA) Weather Radio also provide emergency alerts.
                    -Consider earthquake insurance and a flood insurance policy through the National Flood Insurance Program (NFIP). Standard homeowner’s insurance does not cover flood or earthquake damage.
                """,
                """
                    -If you are in a tsunami area and there is an earthquake, then first protect yourself from the earthquake. Drop, Cover, and Hold On. Drop to your hands and knees. Cover your head and neck with your arms. Hold on to any sturdy furniture until the shaking stops. Crawl only if you can reach better cover, but do not go through an area with more debris.
                    -When the shaking stops, if there are natural signs or official warnings of a tsunami, then move immediately to a safe place as high and as far inland as possible. Listen to the authorities, but do not wait for tsunami warnings and evacuation orders.
                    -If you are outside of the tsunami hazard zone and receive a warning, then stay where you are unless officials tell you otherwise.
                    -Leave immediately if you are told to do so. Evacuation routes are often marked by a wave with an arrow in the direction of higher ground.
                    -If you are in the water, then grab onto something that floats, such as a raft, tree trunk, or door.
                    -If you are in a boat, then face the direction of the waves and head out to sea. If you are in a harbor, then go inland.
                """,
                """
                    -Listen to local alerts and authorities for information on areas to avoid and shelter locations.
                    -Avoid wading in floodwater, which can contain dangerous debris. Water may be deeper than it appears.
                    -Be aware of the risk of electrocution. Underground or downed power lines can electrically charge water. Do not touch electrical equipment if it is wet or if you are standing in water.
                    -Stay away from damaged buildings, roads, and bridges.
                    -Document property damage with photographs. Conduct an inventory and contact your insurance company for assistance.
                    -Save phone calls for emergencies. Phone systems are often down or busy after a disaster. Use text messages or social media to communicate with family and friends.
                """,
                """
                    Information from:
                    https://www.ready.gov/tsunamis
                """
        ],
        
    ]
}
