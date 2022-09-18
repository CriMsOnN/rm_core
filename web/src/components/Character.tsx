import { Button, Center, Divider, Flex } from '@chakra-ui/react';
import { fetchNui } from '../utils/fetchNui';
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
  const handleSelect = () => {
    // setOpenCreateCharacter(true);
    console.log(charid);
    fetchNui('selectCharacter', { charid });
  };

  const handleDelete = () => {
    setOpenDelete(true);
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
        <Button colorScheme="whatsapp" size="sm" onClick={handleSelect}>
          SELECT
        </Button>
        <Button colorScheme="red" size="sm" onClick={handleDelete}>
          DELETE
        </Button>
      </CharacterButtons>
    </>
  );
};

export default Character;
