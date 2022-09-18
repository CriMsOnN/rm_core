import {
  Button,
  ButtonProps,
  Center,
  Divider,
  Flex,
  Square,
  useColorModeValue,
} from '@chakra-ui/react';
import styled from 'styled-components';
import { useNuiEvent } from '../hooks/useNuiEvent';
import { debugData } from '../utils/debugData';
import {
  CharacterBox,
  CharacterButtons,
  CharacterContainer,
  CharacterDetails,
  CharacterList,
  CreateCharacterBox,
} from './styles';
import { useState } from 'react';
import { FaPlusSquare } from 'react-icons/fa';
import ConfirmationDialog from './Dialogs/ConfirmationDialog';
import CreateCharacterDialog from './Dialogs/CreateCharacterDialog';
import Character from './Character';

debugData([
  {
    action: 'setVisible',
    data: true,
  },
]);

type Character = {
  firstname: string;
  lastname: string;
  sex: string;
  dateofbirth: string;
  job: string;
  charid: number;
};

const App = () => {
  const [characters, setCharacters] = useState<Character[]>();
  const [openDelete, setOpenDelete] = useState<boolean>(false);
  const [openCreateCharacter, setOpenCreateCharacter] = useState<boolean>(false);
  useNuiEvent('setCharacters', (data: { characters: Character[] }) => {
    setCharacters(data.characters);
  });
  return (
    <CharacterContainer>
      <CreateCharacterBox onClick={() => setOpenCreateCharacter(true)}>
        <div>
          <FaPlusSquare />
        </div>
        <div>Create Character</div>
      </CreateCharacterBox>
      <CharacterList>
        {characters?.map((character) => (
          <CharacterBox>
            <Character
              firstname={character.firstname}
              lastname={character.lastname}
              sex={character.sex}
              dateofbirth={character.dateofbirth}
              job={character.job}
              charid={character.charid}
              setOpenDelete={setOpenDelete}
            />
          </CharacterBox>
        ))}
      </CharacterList>
      {openDelete && <ConfirmationDialog setOpenDelete={setOpenDelete} isOpen={openDelete} />}
      {openCreateCharacter && (
        <CreateCharacterDialog
          setOpenCreate={setOpenCreateCharacter}
          isOpen={openCreateCharacter}
        />
      )}
    </CharacterContainer>
  );
};

export default App;
