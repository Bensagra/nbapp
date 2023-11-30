import 'colores.dart';

void agregarLogoColorYFondo(List teams) {
  for (var team in teams) {
    team.logo = '${team.abbreviation}.png';
    
    switch (team.abbreviation) {
      case 'ATL':
        team.color = Colores.ATL;

        break;
      case 'BOS':
        team.color = Colores.BOS;
        break;
      case 'BKN':
        team.color = Colores.BKN;
        break;
      case 'CHA':
        team.color = Colores.CHA;
        break;
      case 'CHI':
        team.color = Colores.CHI;
        break;
      case 'CLE':
        team.color = Colores.CLE;
        break;
      case 'DAL':
        team.color = Colores.DAL;
        break;
      case 'DEN':
        team.color = Colores.DEN;
        break;
      case 'DET':
        team.color = Colores.DET;
        break;
      case 'GSW':
        team.color = Colores.GSW;
        break;
      case 'HOU':
        team.color = Colores.HOU;
        break;
      case 'IND':
        team.color = Colores.IND;
        break;
      case 'LAC':
        team.color = Colores.LAC;
        break;
      case 'LAL':
        team.color = Colores.LAL;
        break;
      case 'MEM':
        team.color = Colores.MEM;
        break;
      case 'MIA':
        team.color = Colores.MIA;
        break;
      case 'MIL':
        team.color = Colores.MIL;
        break;
      case 'MIN':
        team.color = Colores.MIN;
        break;
      case 'NOP':
        team.color = Colores.NOP;
        break;
      case 'NYK':
        team.color = Colores.NYK;
        break;
      case 'OKC':
        team.color = Colores.OKC;
        break;
      case 'ORL':
        team.color = Colores.ORL;
        break;
      case 'PHI':
        team.color = Colores.PHI;
        break;
      case 'PHX':
        team.color = Colores.PHX;
        break;
      case 'SAC':
        team.color = Colores.SAC;
        break;
      case 'SAS':
        team.color = Colores.SAS;
        break;
      case 'TOR':
        team.color = Colores.TOR;
        break;
      case 'UTA':
        team.color = Colores.UTA;
        break;
      case 'WAS':
        team.color = Colores.WAS;
        break;

      default:
    }
  }
}
