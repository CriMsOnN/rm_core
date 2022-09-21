import {
  AlertDialog,
  AlertDialogBody,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogOverlay,
  Box,
  Button,
  Flex,
  Text,
} from '@chakra-ui/react';
import { useRef } from 'react';

type Props = {
  setOpenSelection: React.Dispatch<React.SetStateAction<boolean>>;
  firstname: string;
  lastname: string;
  onPlay: () => void;
};

const PlayerConfirmationDialog: React.FC<Props> = ({
  setOpenSelection,
  firstname,
  lastname,
  onPlay,
}) => {
  const ref = useRef(null);
  return (
    <AlertDialog
      isOpen={true}
      onClose={() => setOpenSelection(false)}
      motionPreset="slideInBottom"
      leastDestructiveRef={ref}
    >
      <AlertDialogOverlay style={{ backgroundColor: 'rgba(0, 0, 0, 0.5)' }}>
        <AlertDialogContent style={{ backgroundColor: 'rgba(0, 0, 0, 0.8)', width: '400px' }}>
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
            Character Confirmation
          </AlertDialogHeader>
          <AlertDialogBody>
            <Flex justifyContent="center" alignItems="center">
              <Text color="gray.100">
                Are you use you want to player with{' '}
                <strong>
                  {firstname} {lastname}
                </strong>
                ?
              </Text>
            </Flex>
            <Flex justifyContent="space-around" marginTop="5%">
              <Button colorScheme="whatsapp" size="sm" onClick={onPlay}>
                Play
              </Button>
              <Button colorScheme="red" size="sm" onClick={() => setOpenSelection(false)}>
                Cancel
              </Button>
            </Flex>
          </AlertDialogBody>
        </AlertDialogContent>
      </AlertDialogOverlay>
    </AlertDialog>
  );
};

export default PlayerConfirmationDialog;
