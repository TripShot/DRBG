{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
module Data.Crypto.Classes where

import Data.Binary
import Data.Serialize
import Text.PrettyPrint.HughesPJClass
import Data.ByteString.Lazy
import qualified Data.ByteString as B

type BitLength = Int

class (Binary d, Serialize d, Pretty d) => Hash h d | h -> d where
  outputLength :: h -> BitLength
  hashFunction :: h -> ByteString -> d

class (Binary ct, Serialize ct) => Cipher c ct k | k -> c, c -> ct where
  blockSize       :: c -> BitLength
  cipherFunction  :: k -> ByteString -> ct
  decryptFunction :: k -> ct -> ByteString
  buildKey        :: ByteString -> Maybe k
  keyLength       :: k -> BitLength


{- Example instances 
instance Hash SHA256 DigestSHA256 where
  outputLength _ = 256
  hashFunction = sha256

instance Cipher AES AESCT KeyAES where
  blockSize _ = 128
  cipherFunction = aesE
  decipherFunction = aesD
  buildKey = aesExpandKey
  keyLength = aesKeyLength

-}

-- class (Binary d, Serialize d, Pretty d) => Digest d h | h -> d where
--   hash :: L.ByteString -> d
  
