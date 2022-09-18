import styled from 'styled-components';

export const CharacterContainer = styled.div`
  width: 100%;
  height: 100%;
  overflow: hidden;
`;

export const CharacterList = styled.div`
  position: absolute;
  top: 5%;
  color: white;
  display: flex;
  justify-content: space-around;
  align-items: center;
  width: 100%;
`;

export const CharacterBox = styled.div`
  width: 200px;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 7px;
  flex-direction: column;
`;

export const CreateCharacterBox = styled.div`
  width: 160px;
  height: 30px;
  border-radous: 7px;
  background: rgba(0, 0, 0, 0.2);
  color: white;
  display: flex;
  justify-content: space-around;
  align-items: center;
  margin-top: 20px;
  margin-left: 10px;
  cursor: pointer;
  filter: drop-shadow(0 0 2px #000);
  &:hover {
    background: rgba(0, 0, 0, 0.4);
  }
`;

export const CharacterButtons = styled.div`
  width: 100%;
  display: flex;
  justify-content: space-around;
  padding-bottom: 10px;
  padding-top: 10px;
`;

export const CharacterDetails = styled.div`
  width: 100%;
`;
