--------------------------------------------------------------------------------------------
-- Title: Numeric Textfield
-- Name: Your Name
-- Course: ICS2O/3C
-- What does this program do?
---------------------------------------------------------------------------------------------

-- hide the status bar
--*** INSERT CODE TO HIDE THE STATUS BAR

-- sets the background colour
--*** INSERT CODE TO CHANGE THE BACKGROUND COLOUR

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer

local correctSound = audio.loadSound ("Sounds/correctSound.mp3")
local correctSoundChannel

-- variables for the timer
local totalSeconds = 5
local secondsLeft = 5
local clockText
local countDownTimer

local lives = 3
local heart1
local heart2

--*** ADD LOCAL VARIABLE FOR: INCORRECT OBJECT, POINTS OBJECT, POINTS


-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------


local function UpdateTime()

    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1  
    
    -- display the number of seconds left in the clock object
    clockText.text = secondsLeft .. ""

    if (secondsLeft == 0 ) then
        -- reset the number of seconds left
        secondsLeft = totalSeconds 
        lives = lives - 1

        -- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A YOU LOSE IMAGE 
        -- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE
        if (lives == 2) then
            heart2.isVisible = false
        elseif (lives ==  1) then
            heart1.isVisible = false
        end

        -- *** CALL THE FUNCTION TO ASK A NEW QUESTION
        
    end
end

-- function that calls the timer
local function StartTimer()
    -- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end



local function AskQuestion()
    --*** ADD A COMMENT FOR THE TWO LINES BELOW
    --***CHANGE THE CODE TO USE NUMBERS BETWEEN 0 AND 10
    randomNumber1 = math.random(0, 4)
    randomNumber2 = math.random(0, 4) 

    --*** ADD CODE SO THAT THE OPERATION VARIES RANDOMLY BETWEEN ADDITION, SUBTRACTION 
    --*** AND MULTIPLICATION

    -- calculate the correct answer
    correctAnswer = randomNumber1 + randomNumber2

    -- create question in text object
    questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = " 

end


local function HideCorrect()
    --*** CHANGE THE CORRECT OBJECT TO BE INVISIBLE
	correctObject.isVisible = true

    -- call the function that asks the question
	AskQuestion()
end

local function NumericFieldListener( event )

    -- User begins editing "numericField"
    if (event.phase == "began") then
        
        --clear text field
        event.target.text = ""

    elseif (event.phase == "submitted") then

        -- when the answer is submitted (enter key is pressed) set user input to user's answer
        userAnswer = tonumber(event.target.text)  

        -- if the users answer and the correct answer are the same:
        if (userAnswer == correctAnswer) then
        	correctObject.isVisible = true

        	-- play the bell sound
        	correctSoundChannel = audio.play(correctSound)

            --*** ADD CODE THAT KEEPS TRACK OF THE NUMBER OF POINTS CORRECT AND DISPLAYS THIS IN 
            --*** A TEXT OBJECT

            -- call the HideCorrect function after 2 seconds
        	timer.performWithDelay(2000, HideCorrect)       	               
        	
        end 
    end
end

-----------------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------------

-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

-- displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50 )

--*** INSERT CODE TO CHANGE THE COLOUR OF THE TEXT OBJECT TO A DIFFERENT COLOUR



-- *** INSERT A THIRD HEART

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )

--*** INSERT CODE TO CHANGE THE COLOUR OF THE TEXT OBJECT TO A DIFFERENT COLOUR

--*** MAKE THE CORRECT OBJECT INVISIBLE
correctObject.isVisible = true

-- create the text object to hold the countdown timer
clockText = display.newText(secondsLeft, 150, 80, native.systemFontBold, 80)
clockText:setFillColor( 1, 1, 1 )

-- Create numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80 )
numericField.inputType = "number"

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

-----------------------------------------------------------------------------------------
-- FUNCTION CALLS
-----------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()
StartTimer()

