module BookStructure where

import Data.Map (Map)
import Data.Text
import Network.URI
import Control.Lens

newtype Depth = Depth Int

incDepth :: Depth -> Depth
incDepth (Depth n) = Depth (n+1)

data Span =
  Span Text |
  Mono Text |
  Math Text |
  Parens Span |
  Spans [Span] |
  Emphasis Span |
  GlobalLink URI (Maybe Span)
  deriving (Eq, Show)

data Snippet = Snippet Text
  deriving (Eq, Show)

data Paragraph = Paragraph Span
  deriving (Eq, Show)

data Picture =
  Picture {
    _pictureLink :: Text,
    _pictureComment :: Span
  } deriving (Eq, Show)

data TableRow =
  TableSubsectionRow Unit |
  TableRegularRow [Unit]
  deriving (Eq, Show)

data Table = Table [Unit] [TableRow]
  deriving (Eq, Show)

data Unit =
  UnitParagraph Paragraph |
  UnitTodo Unit |
  UnitNote Unit |
  UnitTip Unit |
  UnitSnippet Snippet |
  UnitList [Unit] |
  UnitTable Table |
  UnitPicture Picture |
  Units [Unit]
  deriving (Eq, Show)

data Section =
  Section {
    _sectionHeader :: Span,
    _sectionUnits :: [Unit],
    _sectionSubsections :: [Section]
  } deriving (Eq, Show)

makeLenses ''Section

newtype ChapterId = ChapterId Text
  deriving (Eq, Ord, Show)

makePrisms ''ChapterId

data TableOfContents =
  TableOfContents {
    _tocChapters :: [ChapterId]
  } deriving (Eq, Show)

makeLenses ''TableOfContents

data Book =
  Book {
    _bookTableOfContents :: TableOfContents,
    _bookChapters        :: Map ChapterId Section
  } deriving (Eq, Show)

makeLenses ''Book
