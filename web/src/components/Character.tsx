import { Button, Center, Divider, Flex } from '@chakra-ui/react';
import { useState } from 'react';
import { useVisibility } from '../providers/VisibilityProvider';
import { fetchNui } from '../utils/fetchNui';
import PlayerConfirmationDialog from './Dialogs/PlayerConfirmationDialog';
import { CharacterButtons, CharacterDetails } from './styles';

type Props = {
  firstname: string;
  lastname: string;
  sex: string;
  dateofbirth: string;
  job: string;
  charid: number;
  setOpenDelete: React.Dispatch<React.SetStateAction<boolean>>;
};

const Character: React.FC<Props> = ({
  firstname,
  lastname,
  sex,
  dateofbirth,
  job,
  charid,
  setOpenDelete,
}) => {
  const [openSelection, setOpenSelection] = useState<boolean>(false);
  const visibility = useVisibility();

  const play = () => {
    visibility.setVisible(false);
    fetchNui('selectCharacter', { charid });
    setOpenSelection(false);
  };

  const handleDelete = () => {
    setOpenDelete(true);
  };

  const openSelect = () => {
    fetchNui('previewCharacter', { charid });
    setOpenSelection(true);
  };

  return (
    <>
      <CharacterDetails>
        <Flex>
          <Center w="100px">Firstname</Center>
          <Center flex="1">{firstname}</Center>
        </Flex>
        <Divider />
        <Flex>
          <Center w="100px">Lastname</Center>
          <Center flex="1">{lastname}</Center>
        </Flex>
        <Divider />
        <Flex>
          <Center w="100px">Sex</Center>
          <Center flex="1">{sex}</Center>
        </Flex>
        <Divider />
        <Flex>
          <Center w="100px">Date of Birth</Center>
          <Center flex="1">{new Date(dateofbirth).toLocaleDateString()}</Center>
        </Flex>
        <Divider />
        <Flex>
          <Center w="100px">Job</Center>
          <Center flex="1">{job}</Center>
        </Flex>
        <Divider />
      </CharacterDetails>
      <CharacterButtons>
        <Button colorScheme="whatsapp" size="sm" onClick={openSelect}>
          SELECT
        </Button>
        <Button colorScheme="red" size="sm" onClick={handleDelete}>
          DELETE
        </Button>
      </CharacterButtons>
      {openSelection && (
        <PlayerConfirmationDialog
          setOpenSelection={setOpenSelection}
          firstname={firstname}
          lastname={lastname}
          onPlay={play}
        />
      )}
    </>
  );
};

export default Character;
