# ox_target
ox_target working with pedhandler

Below is an example of an export w pedhandler.

        exports.ox_target:SpawnPed({
            model = 'a_m_m_indian_01',
            coords = vector3(coords),
            minusOne = true,
            freeze = true,
            invincible = true,
            blockevents = true,
            animDict = 'abigail_mcs_1_concat-0',
            anim = 'csb_abigail_dual-0',
            flag = 1,
            scenario = 'WORLD_HUMAN_AA_COFFEE',
            target = {
                options = {
                    {
                        event = "brito123",
                        icon = "fas fa-circle",
                        label = "justexample",
                    },
                },
                distance = 3.5
            },
            spawnNow = true,
            currentpednumber = 0,
        })
		
