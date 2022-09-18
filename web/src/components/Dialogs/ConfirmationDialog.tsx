import {
  AlertDialog,
  AlertDialogBody,
  AlertDialogContent,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogOverlay,
  Button,
  useDisclosure,
} from '@chakra-ui/react';
import { useRef } from 'react';

type Props = {
  setOpenDelete: React.Dispatch<React.SetStateAction<boolean>>;
  isOpen: true;
};
const ConfirmationDialog: React.FC<Props> = ({ setOpenDelete, isOpen }) => {
  const handleClose = () => {
    setOpenDelete(false);
  };

  const ref = useRef(null);
  return (
    <>
      <AlertDialog isOpen={isOpen} onClose={handleClose} leastDestructiveRef={ref}>
        <AlertDialogOverlay>
          <AlertDialogContent bg={'gray.900'}>
            <AlertDialogHeader fontSize="lg" fontWeight="bold" color="white">
              Delete Character
            </AlertDialogHeader>
            <AlertDialogBody color="white">
              Are you sure you want to delete your character?
            </AlertDialogBody>

            <AlertDialogFooter>
              <Button ref={ref} onClick={handleClose} color="white">
                Cancel
              </Button>
              <Button colorScheme="red" onClick={handleClose} ml={3}>
                Delete
              </Button>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialogOverlay>
      </AlertDialog>
    </>
  );
};

export default ConfirmationDialog;
