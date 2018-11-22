local imgFirebreath = love.graphics.newImage("assets/firebreath.png")
local imgSpark = love.graphics.newImage("assets/spark.png")
local imgSaber = love.graphics.newImage("assets/saiba.png")
local imgSasori = love.graphics.newImage("assets/sprite_all.png")
local imgSaberMove = love.graphics.newImage("assets/saber_move.png")

return {
    fxFireBreath = {
        image = imgFirebreath,
        frameW = 336,
        frameH = 188,
        default = {
            y = 1,
            duration = 0.08
        },
        blendmode = "add",
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5},
            {x = 6},
            {x = 7},
            {x = 8},
            {x = 9},
            {x = 10},
            {x = 11},
            {x = 12}
        }
    },
    fxSpark = {
        image = imgSpark,
        frameW = 205,
        frameH = 229,
        default = {
            y = 1,
            axisX = 108,
            axisY = 118,
            duration = 0.1
        },
        blendmode = "add",
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5}
        }
    },
    saberIdle = {
        image = imgSaberMove,
        frameW = 77,
        frameH = 60,
        default = {
            y = 1,
            axisX = 42,
            axisY = 54,
            duration = 0.13
        },
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5}
        }
    },
    saberRun = {
        image = imgSaberMove,
        frameW = 77,
        frameH = 60,
        default = {
            y = 3,
            axisX = 42,
            axisY = 54,
            duration = 0.05
        },
        frames = {
            {x = 7},
            {x = 8},
            {x = 9},
            {x = 1, y = 4},
            {x = 2, y = 4},
            {x = 3, y = 4},
            {x = 4, y = 4},
            {x = 6},
        }
    },
    saberWalk = {
        image = imgSaberMove,
        frameW = 77,
        frameH = 60,
        default = {
            y = 2,
            axisX = 42,
            axisY = 54,
            duration = 0.06
        },
        frames = {
            {x = 9, y = 1},
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5},
            {x = 6},
            {x = 7}
        }
    },
    saberTurn = {
        image = imgSaberMove,
        frameW = 77,
        frameH = 60,
        default = {
            axisX = 42,
            axisY = 54,
            duration = 0.2
        },
        frames = {
            {x = 6, y = 1}
        }
    },
    saberAttack1 = {
        image = love.graphics.newImage("assets/saber_attack1.png"),
        frameW = 111,
        frameH = 90,
        default = {
            y = 1,
            axisX = 51,
            axisY = 83
        },
        frames = {
            {x = 2, duration = 2 / 60},
            {x = 3, duration = 3 / 60},
            {x = 4, duration = 2 / 60},
            {x = 5, duration = 8 / 60},
            {x = 1, duration = 5 / 60}
        }
    },
    saberJumpStart = {
        image = imgSaberMove,
        frameW = 77,
        frameH = 60,
        default = {
            axisX = 42,
            axisY = 54,
            duration = 4 / 60
        },
        frames = {
            {x = 7, y = 1}
        }
    },
    saberJumpAscending = {
        image = imgSaberMove,
        frameW = 77,
        frameH = 60,
        default = {
            axisX = 42,
            axisY = 54,
            duration = 5 / 60,
            y = 3
        },
        frames = {
            {x = 8, y = 2},
            {x = 9, y = 2},
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5},
        }
    },
    saberJumpLand = {
        image = imgSaberMove,
        frameW = 77,
        frameH = 60,
        default = {
            axisX = 42,
            axisY = 54,
        },
        frames = {
            {x = 7, y = 1, duration =  1/60},
            {x = 5, y = 4, duration =  3/60},
            {x = 8, y = 1, duration =  5/60},
            {x = 5, y = 4, duration =  7/60},
            {x = 7, y = 1, duration =  9/60},
        }
    },
    fxLand = {
        image = love.graphics.newImage("assets/fxLand.png"),
        frameW = 249,
        frameH = 32,
        default = {
            y = 1,
            axisX = 124,
            axisY = 16,
            duration = 2 / 60
        },
        blendmode = "add",
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5},
        }
    },
    fxChakra = {
        image = love.graphics.newImage("assets/chakra.png"),
        frameW = 195,
        frameH = 238,
        default = {
            y = 1,
            axisX = 87,
            axisY = 111,
            duration = 0.05
        },
        blendmode = "add",
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5},
            {x = 6},
            {x = 7},
            {x = 8},
            {x = 9},
            {x = 10}
        }
    },
    fxSwirl = {
        image = love.graphics.newImage("assets/swirl.png"),
        frameW = 416,
        frameH = 292,
        default = {
            y = 1,
            axisX = 93,
            axisY = 259,
            duration = 1 / 60
        },
        blendmode = "add",
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5},
            {x = 6},
            {x = 7},
            {x = 8},
            {x = 9},
            {x = 10},
            {x = 11},
            {x = 12},
            {x = 13},
            {x = 14},
            {x = 15},
            {x = 16}
        }
    },
    fxSwirl2 = {
        image = love.graphics.newImage("assets/swirl2.png"),
        frameW = 223,
        frameH = 121,
        default = {
            y = 1,
            axisX = 111,
            axisY = 61,
            duration = 1 / 60
        },
        blendmode = "add",
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5},
            {x = 6},
            {x = 7},
            {x = 8},
            {x = 9},
            {x = 10},
            {x = 11},
            {x = 12},
            {x = 13},
            {x = 14},
            {x = 15},
            {x = 16},
            {x = 17},
            {x = 18},
            {x = 19},
            {x = 20}
        }
    },
    fxHitSpark = {
        image = love.graphics.newImage("assets/hitspark.png"),
        frameW = 214,
        frameH = 147,
        default = {
            y = 1,
            axisX = 105,
            axisY = 73,
            duration = 1 / 60
        },
        blendmode = "add",
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5},
            {x = 6},
            {x = 7},
            {x = 8},
            {x = 9},
            {x = 10},
            {x = 11},
            {x = 12},
            {x = 13},
            {x = 14},
            {x = 15},
            {x = 16},
            {x = 17},
            {x = 18}
        }
    },
    fxRun = {
        image = love.graphics.newImage("assets/run_fx.png"),
        frameW = 159,
        frameH = 122,
        default = {
            y = 1,
            axisX = 24,
            axisY = 96,
            duration = 3 / 60
        },
        blendmode = "add",
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5},
            {x = 6}
        }
    },
    fxSlash1 = {
        image = love.graphics.newImage("assets/slash1.png"),
        frameW = 177,
        frameH = 233,
        default = {
            y = 1,
            axisX = 88,
            axisY = 116,
            duration = 2 / 60
        },
        blendmode = "add",
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 4},
            {x = 5}
        }
    },
    sasoriIdle = {
        image = imgSasori,
        frameW = 150,
        frameH = 100,
        default = {
            axisX = 75,
            axisY = 90,
            duration = 7 / 60,
            y = 2,
        },
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 2},
        }
    },
    sasoriIdle = {
        image = imgSasori,
        frameW = 150,
        frameH = 100,
        default = {
            axisX = 75,
            axisY = 90,
            duration = 7 / 60,
            y = 2,
        },
        frames = {
            {x = 1},
            {x = 2},
            {x = 3},
            {x = 2},
        }
    },
    sasoriWalk = {
        image = imgSasori,
        frameW = 150,
        frameH = 100,
        default = {
            axisX = 75,
            axisY = 90,
            duration = 6 / 60,
            y = 2,
        },
        frames = {
            {x = 4},
            {x = 5},
            {x = 6},
            {x = 7},
            {x = 8},
            {x = 9},
        }
    },
    fxKindred = {
        image = love.graphics.newImage("assets/Kindred_Skin01_P_flames.dds"),
        frameW = 32,
        frameH = 32,
        default = {
            axisX = 16,
            axisY = 16,
            duration = 2 / 60,
        },
        blendmode = "add",
        frames = {
            {x = 1, y = 1},
            {x = 2, y = 1},
            {x = 3, y = 1},
            {x = 4, y = 1},
            {x = 1, y = 2},
            {x = 2, y = 2},
            {x = 3, y = 2},
            {x = 4, y = 2},
        }
    },
    fxElectric = {
        image = love.graphics.newImage("assets/Kayle_Skin07_E_Electric3.dds"),
        frameW = 128,
        frameH = 128,
        default = {
            axisX = 64,
            axisY = 64,
            duration = 5 / 60,

        },
        blendmode = "add",
        frames = {
            {x = 1, y = 1},
            {x = 2, y = 1},
            {x = 3, y = 1},
            {x = 4, y = 1},
            {x = 1, y = 2},
            {x = 2, y = 2},
            {x = 3, y = 2},
            {x = 4, y = 2},
            {x = 1, y = 3},
            {x = 2, y = 3},
            {x = 3, y = 3},
            {x = 4, y = 3},
            {x = 1, y = 4},
            {x = 2, y = 4},
            {x = 3, y = 4},
            {x = 4, y = 4},
        }
    },
}
--