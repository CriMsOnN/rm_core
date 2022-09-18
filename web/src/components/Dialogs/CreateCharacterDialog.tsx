import React, { useRef } from 'react';
import {
  AlertDialog,
  AlertDialogBody,
  AlertDialogContent,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogOverlay,
  Button,
  Flex,
  Input,
  Select,
  Slide,
  Stack,
  Text,
  useDisclosure,
} from '@chakra-ui/react';
import { fetchNui } from '../../utils/fetchNui';
import { useVisibility } from '../../providers/VisibilityProvider';

type Props = {
  setOpenCreate: React.Dispatch<React.SetStateAction<boolean>>;
  isOpen: boolean;
};

const CreateCharacterDialog: React.FC<Props> = ({ setOpenCreate, isOpen }) => {
  const [firstname, setFirstname] = React.useState('');
  const [lastname, setLastname] = React.useState('');
  const [sex, setSex] = React.useState('');
  const [dateofbirth, setDateofbirth] = React.useState('');
  const [error, setError] = React.useState<string | null>(null);
  const visibility = useVisibility();
  const createCharacter = () => {
    setTimeout(() => {
      setError(null);
    }, 5000);
    if (firstname === '' || lastname === '') {
      return setError('Please fill in all fields');
    }
    if (sex === '') {
      return setError('Please select a sex');
    }

    if (dateofbirth === '') {
      return setError('Please select a date of birth');
    }
    fetchNui('createCharacter', { firstname, lastname, dateofbirth, sex });
    handleClose();
    visibility.setVisible(false);
  };

  const handleClose = () => {
    setOpenCreate(false);
  };

  const ref = useRef(null);
  return (
    <AlertDialog
      isOpen={isOpen}
      onClose={handleClose}
      leastDestructiveRef={ref}
      motionPreset="slideInBottom"
      isCentered
    >
      <AlertDialogOverlay
        style={{
          backgroundColor: 'rgba(0, 0, 0, 0.5)',
        }}
      >
        <AlertDialogContent
          style={{
            backgroundColor: 'rgba(0, 0, 0, 0.4)',
            width: '300px',
          }}
        >
          <AlertDialogHeader
            fontSize="lg"
            fontWeight="bold"
            color="white"
            style={{
              display: 'flex',
              justifyContent: 'center',
              alignItems: 'center',
            }}
          >
            Character Creation
          </AlertDialogHeader>
          <AlertDialogBody>
            <Flex justifyContent="center" alignItems="center">
              <Text color="red.500">{error}</Text>
            </Flex>
            <Flex justifyContent="space-around">
              <Input
                variant="flushed"
                placeholder="Firstname"
                width="100px"
                color="white"
                value={firstname}
                onChange={(e) => setFirstname(e.target.value)}
              />
              <Input
                variant="flushed"
                placeholder="Lastname"
                width="100px"
                color="white"
                value={lastname}
                onChange={(e) => setLastname(e.target.value)}
              />
            </Flex>
            <Flex justifyContent="center" alignItems="center">
              <Input
                variant="flushed"
                type="date"
                width="200px"
                color="white"
                style={{ textAlign: 'center' }}
                value={dateofbirth}
                onChange={(e) => setDateofbirth(e.target.value)}
              />
            </Flex>
            <Flex justifyContent="center" alignItems="center">
              <Select
                placeholder="Sex"
                size="md"
                variant="flushed"
                style={{ color: 'white', textAlign: 'center' }}
                width="200px"
                value={sex}
                onChange={(e) => setSex(e.target.value)}
              >
                <option
                  value="male"
                  style={{ borderTop: 'none', borderBottom: 'none', outline: 'none' }}
                >
                  Male
                </option>
                <option value="female">Female</option>
              </Select>
            </Flex>
            <Flex justifyContent="center" alignItems="center" marginTop="20px">
              <Button variant="solid" colorScheme="whatsapp" onClick={createCharacter}>
                Create
              </Button>
            </Flex>
          </AlertDialogBody>
        </AlertDialogContent>
      </AlertDialogOverlay>
    </AlertDialog>
  );
};

export default CreateCharacterDialog;
