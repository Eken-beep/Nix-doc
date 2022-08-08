module Main where

import System.Environment
import System.Exit
import System.Directory
import System.Process
import Data.List
import Data.Char

----------------
-- Main function
main :: IO ()
main = do 
    args <- getArgs
    home <- getHomeDirectory
    
    fileName <- parse args

    let command = "cat " ++ home ++ "/.local/share/nix-doc/" ++ fileName ++ ".txt | less"
   
    (_, _, _, handle) <- createProcess $ shell command
    waitForProcess handle

    print command
    exitSuccess

-----------------------
-- Parsing of arguments

parse []         = noArgs >> exitSuccess
parse ["-h"]     = usage  >> exitSuccess
parse ["-o"]     = noPage >> exitSuccess

parse ["-o", fn] = return fn

parse _          = invalidArguments >> exitWith (ExitFailure 1)

usage            = putStrLn "Usage i cant be bothered writing rn"
noArgs           = putStrLn "Error: No arguments given"
noPage           = putStrLn "No pagename given"
invalidArguments = putStrLn "Error invalid arguments"
